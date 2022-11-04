#!/bin/bash

if python OnlyFlights-Database-tables.py
    then
        echo "Successfully execute code"
    else
        echo "Failure"
fi

echo "All done"
