#!/bin/bash

# Start the Flask application inside a Docker container
docker run -d -p 5000:5000 jehp/newpro:latest


# Wait for the app to start
sleep 5

# Send a GET request to the /add endpoint with two numbers
response=$(curl -s "http://localhost:5000/add?num1=10&num2=20")

# Expected result
expected="30.0"

# Compare the response with the expected value
if [ "$response" == "$expected" ]; then
  echo "Test Passed: The /add endpoint is working correctly."
  exit 0
else
  echo "Test Failed: Expected $expected but got $response."
  exit 1
fi

# Clean up the container
docker rm -f flask-app
