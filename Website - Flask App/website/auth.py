from flask import Blueprint, render_template, request, flash, redirect, url_for
from .valid import checkName, checkPassword, checkEmail
from .models import Users
from werkzeug.security import generate_password_hash, check_password_hash
from . import db
from flask_login import login_user, login_required, logout_user

# Initialize auth blueprint
auth = Blueprint('auth', __name__)


# Define /login route with two accepted methods
@auth.route('/login', methods=['GET', 'POST'])
# Initialize login method
def login():
    # Check if method is POST
    if request.method == 'POST':
        # If it is, get the email and password from the form
        email = request.form.get('email')
        password = request.form.get('password')

        # Get user with matching email from database
        user = Users.query.filter_by(email=email).first()
        # Check if user actually exists
        if user:
            # If it does check if the hashed password matches the hash in the database
            if check_password_hash(user.password, password):
                # flash('logged in', category='success')
                # If it does, call login_user() which saves the user in the session and remember it for the session
                login_user(user, remember=True)
                # Return a redirect to the home page
                return redirect(url_for('views.home'))
            else:
                # If it doesn't match the database reload the login page
                # flash('incorrect pass', category='error')
                return render_template("login.html")
        else:
            # If the user doesn't exist return an error message
            flash('email doesnt exist', category='error')
    # Load the login page
    return render_template("login.html")


# Define /signup route with two accepted methods
@auth.route('/signup', methods=['GET', 'POST'])
# Initialize login method
def signup():
    # Check if method is POST
    if request.method == 'POST':
        # If it is get the name, email, password and password confirmation from the form
        name = request.form.get('name')
        email = request.form.get('email')
        password1 = request.form.get('password1')
        password2 = request.form.get('password2')

        # Get the first user in the database with this email
        user = Users.query.filter_by(email=email).first()

        # Check if there is such a user
        if user:
            # If there is return an error
            # flash('Invalid Email', category='error')
            pass
        # Else check if name is valid
        elif not checkName(name):
            # If it doesn't return an error
            # flash('Invalid name', category='error')
            print(1)
            pass
        # Else check if email is valid
        elif not checkEmail(email):
            # If it isn't return an error
            # flash('Invalid Email', category='error')
            print(2)
            pass
        # Else check if password is valid
        elif not checkPassword(password1, password2):
            # If it isn't return an error
            # flash('Invalid password', category='error')
            print(3)
            pass
        else:
            # Else create a new user instance and commit it to the database
            new_user = Users(username=email, password=generate_password_hash(password1, method='sha256'), name=name, type=0, email=email)
            db.session.add(new_user)
            db.session.commit()
            # flash('Account created', category='success')

            # Login user to session and remember it
            login_user(new_user, remember=True)
            # redirect to the home page
            return redirect(url_for('views.home'))

    # Load the signup page
    return render_template("signup.html")


# Define the /logout route and make it inaccessible to without login
@auth.route('/logout')
@login_required
# Initialize logout method
def logout():
    # Call logout_user which removes it from the session and forgets it
    logout_user()
    # Redirect to the login page
    return redirect(url_for('auth.login'))
