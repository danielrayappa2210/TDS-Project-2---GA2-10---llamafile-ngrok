FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y docker.io wget tar jq curl

# Download and install ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O ngrok.tgz && \
    tar -xvzf ngrok.tgz && \
    mv ngrok /usr/local/bin/ && \
    rm ngrok.tgz

# Copy the script and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Start the script
CMD ["/start.sh"]