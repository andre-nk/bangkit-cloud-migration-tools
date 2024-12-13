#!/bin/sh

# Check if ENV variable exists and is set to PROD == true
if [ "${ENV}" = "PROD" ]; then
    # Add your production-specific commands here
    echo "Running in Production Mode"
    cp krakend-prod.json krakend.json

else
    echo "Running in Development Mode"
    cp krakend-dev.json krakend.json
fi

krakend run -c /etc/krakend/krakend.json