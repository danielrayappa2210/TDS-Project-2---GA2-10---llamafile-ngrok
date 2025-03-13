#!/bin/bash

# Run llama-server container from Docker Hub
docker run -d --name llama-container -p 9090:9090 your-dockerhub-username/llama-server:latest

# Run ngrok to tunnel the connection
ngrok authtoken $NGROK_AUTH_TOKEN

# Expose port 9090
ngrok http 9090 --log="stdout" &

# Get the ngrok URL
sleep 10

ngrok_url=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

if [[ -z "$ngrok_url" ]]; then
    echo "Error: Could not retrieve ngrok URL."
    exit 1
fi

echo "ngrok URL: $ngrok_url"

# Keep the script running
wait