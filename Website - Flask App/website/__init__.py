from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from os import path
from flask_login import LoginManager

# Initialize environment, database API and global variables
app = Flask(__name__)
db = SQLAlchemy()
DB_NAME = "mock_db.db"
airport_names = []


# Method create_app() is initialized
def create_app():

    # Configure secret key for connection
    app.config['SECRET_KEY'] = 'funkyass secret key'

    # establish connection with the database instance
    # app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{DB_NAME}'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://Admin:<9RO+vnr2S@onlyflights-database.cr78vmvzrhy0.eu-central-1.rds.amazonaws.com:3306/OnlyFlightsDB'
    db.init_app(app)

    # Import auth and views
    from .auth import auth
    from .views import views

    # register the routes in views and auth as blueprints
    app.register_blueprint(views, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    # import Users schema
    from .models import Users

    # Create database in database instance if it doesn't already exist
    # create_database(app)
    if not path.exists('website/' + DB_NAME):
        with app.app_context():
            db.create_all()
            print('Created Database!')

    # Initialize login_manager and add redirect to login page
    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    # import library and Airports schema
    import requests
    from .models import Airports

    # Initialize api_key for third party database
    params = {
        'api_key': 'fbdecbed-1d77-49d0-b118-fc44c8ca3913'
    }
    # Choose from which database to request data
    method = 'airports'
    # Initialize URI of database
    api_base = 'http://airlabs.co/api/v9/'
    # Get result from query of all airports
    api_result = requests.get(api_base + method, params)
    # Transfer result to JSON
    api_response = api_result.json()

    # Create context for usage of database without an initialized app
    with app.app_context():

        # For each element in the response header
        for i in api_response["response"]:
            # Check if airport has IATA code
            if i.get('iata_code') is not None:
                # If it does add name to list
                airport_names.append(i.get('name'))

        # Sort finished list alphabetically
        airport_names.sort()

        # Check if Airports table in database is empty
        if Airports.query.count() == 0:
            # If it is, go through each element in the response header
            for i in api_response["response"]:
                # Check if airport has IATA code
                if i.get('iata_code') is not None:
                    # If it does check if airport is already in database
                    if not Airports.query.filter_by(iata_code=i.get('iata_code')).first():
                        # If it isn't create new airport instance and add it to the database
                        new_airport = Airports(iata_code=i.get('iata_code'), icao_code=i.get('icao_code'), name=i.get('name'),
                                               latitude=i.get('lat'), longitude=i.get('lng'), country_code=i.get('country_code'))
                        db.session.add(new_airport)
                        db.session.commit()
        else:
            # If database isn't empty skip
            print("DB full")
        # Commit any unsaved changes to the database
        db.session.commit()

    # Define method load_user(id)
    @login_manager.user_loader
    def load_user(id):
        # Returns users' id
        return Users.query.get(int(id))

    # Returns app
    return app
