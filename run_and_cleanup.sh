#!/bin/bash

# Set variables
IMAGE_NAME="docker.io/danielrayappa/llama-server:latest"
CONTAINER_NAME="llama-server-container"
PORT_MAPPING="9090:9090"
RUN_TIME=300 # Run for 5 minutes

# Run the container in detached mode
docker run -d --name "$CONTAINER_NAME" -p "$PORT_MAPPING" "$IMAGE_NAME"

# Wait for the specified time
sleep "$RUN_TIME"

# Stop the container (forcefully if needed)
docker stop "$CONTAINER_NAME" || docker kill "$CONTAINER_NAME"

# Remove the container (forcefully if needed)
docker rm -f "$CONTAINER_NAME"

# Remove the image (forcefully if needed)
docker rmi -f "$IMAGE_NAME"

# Remove dangling volumes
dangling_volumes=$(docker volume ls -q -f dangling=true)
if [ -n "$dangling_volumes" ]; then
    docker volume rm $(docker volume ls -q -f dangling=true)
fi

echo "Container, image, and dangling volumes cleaned up."
