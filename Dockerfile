FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y docker.io wget tar jq

# Download and install ngrok
RUN wget https://bin.equinox.io/linux/amd64/ngrok-stable && \
    tar -xvzf ngrok-stable && \
    mv ngrok /usr/local/bin/

# Copy the script and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Start the script
CMD ["/start.sh"]