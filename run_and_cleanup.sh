#!/bin/bash

# Set variables
IMAGE_NAME="docker.io/danielrayappa/llama-server:latest"
CONTAINER_NAME="llama-server-container"
PORT_MAPPING="9090:9090"
RUN_TIME=300 # Run for 30 seconds

# Run the container in detached mode
podman run -d --name "$CONTAINER_NAME" -p "$PORT_MAPPING" "$IMAGE_NAME"

# Wait for the specified time
sleep "$RUN_TIME"

# Stop the container (forcefully if needed)
podman stop "$CONTAINER_NAME" || podman kill "$CONTAINER_NAME"

# Remove the container (forcefully if needed)
podman rm -f "$CONTAINER_NAME"

# Remove the image (forcefully if needed)
podman rmi -f "$IMAGE_NAME"

# Remove dangling volumes
dangling_volumes=$(podman volume ls -q -f dangling=true)
if [ -n "$dangling_volumes" ]; then
    podman volume rm $(podman volume ls -q -f dangling=true)
fi

echo "Container, image, and dangling volumes cleaned up."
