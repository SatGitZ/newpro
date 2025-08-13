#!/bin/bash


#!/bin/bash

IMAGE_NAME="jehp/newpro:latest"

# Start the container
docker run -d -p 5000:5000 --name flask-test-container $IMAGE_NAME
sleep 5  # wait for app to start (increase if needed)

# Optional: Check if container is running
if ! docker ps | grep -q flask-test-container; then
  echo "Container failed to start"
  exit 1
fi

# Send test request
RESPONSE=$(curl -s --max-time 10 "http://localhost:5000/add?num1=10&num2=20")

EXPECTED="30.0"
if [ "$RESPONSE" = "$EXPECTED" ]; then
    echo "Test Passed: $RESPONSE"
    docker rm -f flask-test-container
    exit 0
else
    echo "Test Failed: Expected $EXPECTED but got $RESPONSE"
    docker rm -f flask-test-container
    exit 1
fi