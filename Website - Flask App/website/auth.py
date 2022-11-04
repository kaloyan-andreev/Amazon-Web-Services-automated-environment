from flask import Blueprint, render_template, request, flash, redirect, url_for
from .valid import checkName,checkPassword,checkEmail
from .models import Users
from werkzeug.security import generate_password_hash, check_password_hash
from . import db
from flask_login import login_user, login_required, logout_user, current_user

auth = Blueprint('auth', __name__)

@auth.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        user = Users.query.filter_by(email=email).first()
        if user:
            if check_password_hash(user.password, password):
                # flash('logged in', category='success')
                login_user(user, remember=True)
                return redirect(url_for('views.home'))
            else:
                # flash('incorrect pass', category='error')
                return render_template("login.html")
        else:
            flash('email doesnt exist', category='error')
    return render_template("login.html")

@auth.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        password1 = request.form.get('password1')
        password2 = request.form.get('password2')

        user = Users.query.filter_by(email=email).first()

        if user:
            # flash('Invalid Email', category='error')
            pass
        elif not checkName(name):
            # flash('Invalid name', category='error')
            print(1)
            pass
        elif not checkEmail(email):
            # flash('Invalid Email', category='error')
            print(2)
            pass
        elif not checkPassword(password1, password2):
            # flash('Invalid password', category='error')
            print(3)
            pass
        else:
            new_user = Users(username=email, password=generate_password_hash(password1, method='sha256'), name=name, type=0, email=email)
            db.session.add(new_user)
            db.session.commit()
            # flash('Account created', category='success')
            login_user(user, remember=True)
            return redirect(url_for('views.home'))



    return render_template("signup.html")

@auth.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('auth.login'))