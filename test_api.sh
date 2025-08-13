#!/bin/bash
IMAGE_NAME="satven/newpro:latest"
CONTAINER_NAME="flask-test-container"

# Clean up any previous container with the same name
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Removing existing container: $CONTAINER_NAME"
    docker rm -f $CONTAINER_NAME
fi

# Start the container
docker run -d -p 5000:5000 --name $CONTAINER_NAME $IMAGE_NAME

# Wait for the Flask app to be ready
echo "Waiting for Flask app to start..."
sleep 5

# Test the /add API
RESPONSE=$(curl -s "http://localhost:5000/add?num1=10&num2=20")
EXPECTED="30.0"

if [ "$RESPONSE" = "$EXPECTED" ]; then
    echo "Test Passed: $RESPONSE"
    docker rm -f $CONTAINER_NAME
    exit 0
else
    echo "Test Failed: Expected $EXPECTED but got '$RESPONSE'"
    echo "Container logs:"
    docker logs $CONTAINER_NAME || true
    docker rm -f $CONTAINER_NAME
    exit 1
fi
