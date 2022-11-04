import mysql.connector
from mysql.connector import Error


# Connect to RDS MySQL Database
connection = mysql.connector.connect(host='only-flights-database.cr78vmvzrhy0.eu-central-1.rds.amazonaws.com',
                                        database='mydb',
                                        user='user1',
                                        password='password')

c = connection.cursor()

# Create Registration table
def create_tables():

    execute = ["""
        CREATE TABLE IF NOT EXISTS Users ( 
            id int AUTO_INCREMENT NOT NULL,
            username varchar(250) NOT NULL,
            password varchar(250) NOT NULL,
            first_name varchar(250) NOT NULL,
            last_name varchar(250) NOT NULL,
            type int NOT NULL,
            date_of_birth date NOT NULL,
            email_address varchar(250) NOT NULL,
            phone bigint NOT NULL,
            is_employee boolean NOT NULL,

            PRIMARY KEY (id)
        )""",
        
        """CREATE TABLE IF NOT EXISTS SupportLogs (
            id int AUTO_INCREMENT NOT NULL,
            employee_id int NOT NULL,
            user_id int NOT NULL,
            start datetime NOT NULL,
            status int NOT NULL,

            PRIMARY KEY (id),

            FOREIGN KEY (user_id)
                REFERENCES Users(id)
        )""",
        
        """CREATE TABLE IF NOT EXISTS Airports (
            id varchar(250) NOT NULL,
            name varchar(250) NOT NULL,
            latitude float NOT NULL,
            longitude float NOT NULL,
            height float NOT NULL,
            timezone int NOT NULL,

            PRIMARY KEY (id)
        )""",
        
        """CREATE TABLE IF NOT EXISTS Aircrafts (
            id int NOT NULL,
            producer varchar(250) NOT NULL,
            model varchar(250) NOT NULL,
            capacity varchar(250) NOT NULL,
            type int NOT NULL,
            status int NOT NULL,

            PRIMARY KEY (id)
        )""",

        """CREATE TABLE IF NOT EXISTS Flights (
            id int AUTO_INCREMENT NOT NULL,
            destination varchar(250) NOT NULL,
            plane_id int NOT NULL,
            origin varchar(250) NOT NULL,
            check_in datetime NOT NULL,
            terminal int NOT NULL,
            gate datetime NOT NULL,
            take_off datetime NOT NULL,
            duration time NOT NULL,
            status int NOT NULL,
            delay time NOT NULL,

            PRIMARY KEY (id),

            FOREIGN KEY (plane_id)
                REFERENCES Aircrafts(id),

            FOREIGN KEY (destination)
                REFERENCES Airports(id)
        )""",

        """CREATE TABLE IF NOT EXISTS Tickets (
            id int AUTO_INCREMENT NOT NULL,
            flight_id int NOT NULL,
            user_id int NOT NULL,
            type int NOT NULL,
            carry_on int NOT NULL,
            check_in int NOT NULL,
            sport_equipment int NOT NULL,
            status int NOT NULL,

            PRIMARY KEY (id),
            
            FOREIGN KEY (flight_id)
                REFERENCES Flights(id),

            FOREIGN KEY (user_id)
                REFERENCES Users(id)
        )""",

        """CREATE TABLE IF NOT EXISTS Luggage (
            id int AUTO_INCREMENT NOT NULL,
            ticket_id int NOT NULL,
            type int NOT NULL,
            weight int NOT NULL,
            status int NOT NULL,

            PRIMARY KEY (id),

            FOREIGN KEY (ticket_id)
                REFERENCES Tickets(id)
        )"""
        ]

    for i in execute:
        try:
            c.execute(i)
            connection.commit()
            print("Successfully created table")
        
        except mysql.connector.Error as error:
            print("There was an error while creating certain table {}".format(error))

create_tables()

# Remove tables from database
def remove_tables():
    sql = "DROP TABLE IF EXISTS Aircrafts, Users, Luggage, Flights, Tickets, Airports, SupportLogs"

    c.execute(sql)
    connection.commit()
    print("yes")

# remove_tables()