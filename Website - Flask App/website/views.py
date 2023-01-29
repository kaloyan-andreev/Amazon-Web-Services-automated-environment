from flask import Blueprint, render_template, request, flash
from flask_login import login_required, current_user
from .models import Airports, Flights, Tickets, Users
from .valid import checkPassword
from werkzeug.security import generate_password_hash, check_password_hash
from sqlalchemy import update
from . import airport_names, db
from random import seed, randint
import json
import jsonify
import datetime


# Initialize views blueprint
views = Blueprint('views', __name__)
seed(10)


# Define / route with two accepted methods and make it inaccessible to without login
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

        print(flights)

        # Print values for testing
        print(orig_name.iata_code)
        print(orig)
        print(dest)
        print(date1)
        print(date2)

        # Load the home page with passed variables: user, list of airports and list of flights
        return render_template("index.html", user=current_user, arr=airport_names, flights=flights)

    # Load the home page with passed variables: user and list of airports
    return render_template("index.html", user=current_user, arr=airport_names)


# Define the /profile route with two accepted methods inaccessible to without login
@views.route('/profile', methods=['GET', 'POST'])
@login_required
# Initialize the profile() method
def profile():
    # Get all the tickets of the current user
    tickets = Tickets.query.filter_by(user_id=current_user.id)
    print(datetime.date.today())

    # Load the profile page with passed variables: user and list of tickets
    return render_template("profile.html", user=current_user, tickets=tickets, today=datetime.date.today())


# Define the /chnage-pass route with 1 accepted method inaccessible to without login
@views.route('/change-pass', methods=['POST'])
@login_required
# initialize changePass() method
def changePass():
    # Get data from packet
    data = json.loads(request.data)
    currPass = data['currPass']
    newPass = data['newPass']
    secPass = data['secPass']

    # Get current user
    print(current_user.username)
    user = Users.query.filter_by(id=current_user.id).first()
    print(user.id)

    if check_password_hash(user.password, currPass):
        if checkPassword(newPass, secPass):
            # user.name = newPass
            # secPass = generate_password_hash(newPass)

            print(Users.query.filter_by(id=current_user.id).first().password)

            u = update(Users)
            u = u.values({"password": generate_password_hash(newPass)})
            u = u.where(Users.id == user.id)
            db.session.execute(u)
            db.session.commit()
        else:
            print("Password validation check error")
    else:
        print("Incorrect password")

    print(Users.query.filter_by(id=current_user.id).first().password)
    return


@views.route('/add-flight', methods=['POST'])
def add_flight():
    flight = json.loads(request.data)
    flightID = flight['flightID']
    userID = flight['userID']
    flight = Flights.query.get(flightID)
    value = randint(0, 2147483647)
    new_ticket = None
    for i in range(10):

        if Tickets.query.get(value) is None:
            new_ticket = Tickets(id=value, flight_id=flight.id, user_id=userID, type=1, carry_on=0, check_in=0, sport_eq=0, status=1)
        else:
            value = randint(0, 2147483647)

    if new_ticket is None:
        print("There was a problem creating the ticket. Please try again")
        return jsonify({})

    db.session.add(new_ticket)
    db.session.commit()
    flash('Ticket added!', category='success')

    return jsonify({})


@views.route('/delete-ticket', methods=['POST'])
def delete_ticket():
    ticket = json.loads(request.data)
    ticketID = ticket['ticketID']
    ticket = Tickets.query.get(ticketID)
    if ticket:
        if ticket.user_id == current_user.id:
            db.session.delete(ticket)
            db.session.commit()

    return jsonify({})
