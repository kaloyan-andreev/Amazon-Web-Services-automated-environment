from flask import Flask, render_template, request
from website import create_app

app = create_app()

# @app.route("/")
# def index():
#     return render_template("index.html")
#
# @app.route("/about")
# def login():
#     return render_template("login.html")
#
# @app.route("/profile")
# def profile():
#     return render_template("profile.html")

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')