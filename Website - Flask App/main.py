from website import create_app

# Create the app instance by calling create_app() method
app = create_app()

if __name__ == "__main__":
    # Run app with debugger and on every ip address
    app.run(debug=True, host='0.0.0.0', port=80)
