from . import db
from flask_login import UserMixin
from sqlalchemy.sql import func


# Create a schema for the SupportLog table
class SupportLogs(db.Model):
    # Define columns
    id = db.Column(db.Integer, primary_key=True)
    employee_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    start = db.Column(db.DateTime(timezone=True), default=func.now())
    status = db.Column(db.Integer)


# Create a schema for the Airports table
class Airports(db.Model):
    # Define columns
    iata_code = db.Column(db.String(250), primary_key=True)
    icao_code = db.Column(db.String(250))
    name = db.Column(db.String(250))
    latitude = db.Column(db.Float)
    longitude = db.Column(db.Float)
    country_code = db.Column(db.String(250))

    # Define relations
    flight_origin = db.relationship('Flights', foreign_keys='Flights.origin', backref='flight_orig', lazy='dynamic')
    flight_destination = db.relationship('Flights', foreign_keys='Flights.destination', backref='flight_dest',
                                         lazy='dynamic')


# Create a schema for the Aircrafts table
class Aircrafts(db.Model):
    # Define columns
    id = db.Column(db.Integer, primary_key=True)
    producer = db.Column(db.String(250))
    model = db.Column(db.String(250))
    capacity = db.Column(db.Integer)
    type = db.Column(db.Integer)
    status = db.Column(db.Integer)

    # Define relations
    flights = db.relationship('Flights', back_populates='plane')


# Create a schema for the Flights table
class Flights(db.Model):
    # Define columns
    id = db.Column(db.Integer, primary_key=True)
    origin = db.Column(db.String(250), db.ForeignKey('airports.iata_code'))
    destination = db.Column(db.String(250), db.ForeignKey('airports.iata_code'))
    plane_id = db.Column(db.Integer, db.ForeignKey('aircrafts.id'))
    check_in = db.Column(db.Date)
    take_off = db.Column(db.Time(timezone=True))
    terminal = db.Column(db.Integer)
    gate = db.Column(db.Integer)
    duration = db.Column(db.Time)
    status = db.Column(db.Integer)

    # Define relations
    plane = db.relationship('Aircrafts', back_populates='flights')
    tickets = db.relationship('Tickets', back_populates='flight')


# Create a schema for the Tickets table
class Tickets(db.Model):
    # Define columns
    id = db.Column(db.Integer, primary_key=True)
    flight_id = db.Column(db.Integer, db.ForeignKey('flights.id'))
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    type = db.Column(db.Integer)
    carry_on = db.Column(db.Integer)
    check_in = db.Column(db.Integer)
    sport_eq = db.Column(db.Integer)
    status = db.Column(db.Integer)

    # Define relations
    flight = db.relationship('Flights', back_populates='tickets')
    user = db.relationship('Users', back_populates='tickets')
    luggage = db.relationship('Luggage', back_populates='tickets')


# Create a schema for the Luggage table
class Luggage(db.Model):
    # Define columns
    id = db.Column(db.Integer, primary_key=True)
    ticket_id = db.Column(db.Integer, db.ForeignKey('tickets.id'))
    type = db.Column(db.Integer)
    weight = db.Column(db.Integer)
    status = db.Column(db.Integer)

    # Define relations
    tickets = db.relationship('Tickets', back_populates='luggage')


# Create a schema for the Users table
class Users(db.Model, UserMixin):
    # Define columns
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(250), unique=True)
    password = db.Column(db.String(250))
    name = db.Column(db.String(250))
    type = db.Column(db.Integer)
    email = db.Column(db.String(250), unique=True)

    # Define relations
    logs_empl = db.relationship('SupportLogs', foreign_keys='SupportLogs.employee_id', backref='employee', lazy='dynamic')
    logs_cli = db.relationship('SupportLogs', foreign_keys='SupportLogs.user_id', backref='user', lazy='dynamic')
    tickets = db.relationship('Tickets', back_populates='user')
