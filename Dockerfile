# Use a base image that includes bash (or the shell you need)
FROM ubuntu:latest

# Install docker
RUN apt-get update && apt-get install -y docker.io

# Copy your script into the container
COPY run_and_cleanup.sh /app/run_and_cleanup.sh

# Make the script executable
RUN chmod +x /app/run_and_cleanup.sh

# Set the working directory (optional, but good practice)
WORKDIR /app

# Run the script when the container starts
CMD ["./run_and_cleanup.sh"]
