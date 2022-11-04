from . import db
from flask_login import UserMixin
from sqlalchemy.sql import func

# class SupportLogs(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     employee_id = db.Column(db.Integer, db.ForeignKey('users.id'))
#     user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
#     start = db.Column(db.DateTime(timezone=True), default=func.now())
#     status = db.Column(db.Integer)
#
# class Airports(db.Model):
#     id = db.Column(db.String, primary_key=True)
#     name = db.Column(db.String(250))
#     latitude = db.Column(db.Float)
#     longitude = db.Column(db.Float)
#     height = db.Column(db.Float)
#     timezone = db.Column(db.Integer)
#     flights = db.relationship('Flights')
#
# class Aircrafts(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     producer = db.Column(db.String(250))
#     model = db.Column(db.String(250))
#     capacity = db.Column(db.Integer)
#     type = db.Column(db.Integer)
#     status = db.Column(db.Integer)
#     flights = db.relationship('Flights')
#
# class Flights(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     origin = db.Column(db.String, db.ForeignKey('airports.id'))
#     destination = db.Column(db.String, db.ForeignKey('airports.id'))
#     plane_id = db.Column(db.Integer, db.ForeignKey('aircrafts.id'))
#     check_in = db.Column(db.DateTime(timezone=True))
#     take_off = db.Column(db.DateTime(timezone=True))
#     terminal = db.Column(db.Integer)
#     gate = db.Column(db.Integer)
#     duration = db.Column(db.Time)
#     status = db.Column(db.Integer)
#     tickets = db.relationship('Tickets')
#
# class Tickets(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     flight_id = db.Column(db.Integer, db.ForeignKey('flights.id'))
#     user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
#     type = db.Column(db.Integer)
#     carry_on = db.Column(db.Integer)
#     check_in = db.Column(db.Integer)
#     sport_eq = db.Column(db.Integer)
#     status = db.Column(db.Integer)
#     luggages = db.relationship('Luggage')
#
# class Luggage(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     ticket_id = db.Column(db.Integer, db.ForeignKey('tickets.id'))
#     type = db.Column(db.Integer)
#     weight = db.Column(db.Integer)
#     status = db.Column(db.Integer)

class Users(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(250), unique=True)
    password = db.Column(db.String(250))
    name = db.Column(db.String(250))
    type = db.Column(db.Integer)
    email = db.Column(db.String(250), unique=True)
    # tickets = db.relationship('Tickets')
    # logs = db.relationship('SupportLogs')
