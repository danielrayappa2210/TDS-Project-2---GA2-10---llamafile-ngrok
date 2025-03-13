#!/bin/bash

# Run Docker container in the background
docker run -d --name llama-container -p 9090:9090 llama-server

# Install ngrok (if needed)
# wget https://bin.equinox.io/linux/amd64/ngrok-stable
# tar -xvzf ngrok-stable
# mv ngrok /usr/local/bin/

# Run ngrok to tunnel the connection
ngrok authtoken $NGROK_AUTH_TOKEN

# Expose port 9090
ngrok http 9090 --log="stdout" &

# Get the ngrok URL
sleep 5

ngrok_url=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

if [[ -z "$ngrok_url" ]]; then
    echo "Error: Could not retrieve ngrok URL."
    exit 1
fi

echo "ngrok URL: $ngrok_url"

# Keep the script running
wait