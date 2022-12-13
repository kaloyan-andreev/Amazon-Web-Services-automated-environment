from flask import Blueprint, render_template, request
from flask_login import login_required, current_user
from .models import Airports, Flights, Tickets
from . import airport_names


# Initialize views blueprint
views = Blueprint('views', __name__)


# Define route and make it inaccessible to without login
@views.route('/', methods=['GET', 'POST'])
@login_required
# Initialize the home() methods
def home():
    # Check if method is POST
    if request.method == 'POST':

        # If it is get the origin the destination and the start and end date
        orig = request.form.get('orig')
        dest = request.form.get('dest')
        date1 = request.form.get('date1')
        date2 = request.form.get('date2')

        # Get the name of the origin airport
        orig_name = Airports.query.filter_by(name=orig).first()

        # Get a list of flights from a specific airport
        flights = Flights.query.filter_by(origin=orig_name.iata_code)

        # Print values for testing
        print(orig_name.iata_code)
        print(orig)
        print(dest)
        print(date1)
        print(date2)

        # Load the home page with passed variables
        return render_template("index.html",
                               user=current_user,
                               arr=airport_names,
                               flights=flights)

    # Load the home page with passed variables: user and list of airports
    return render_template("index.html", user=current_user, arr=airport_names)


# Define the /profile route inaccessible to without login
@views.route('/profile', methods=['GET', 'POST'])
@login_required
# Initialize the profile() method
def profile():
    # Get all the tickets of the current user
    tickets = Tickets.query.filter_by(id=current_user.id)

    # Load the profile page with passed variables: user and list of tickets
    return render_template("profile.html", user=current_user, tickets=tickets)
