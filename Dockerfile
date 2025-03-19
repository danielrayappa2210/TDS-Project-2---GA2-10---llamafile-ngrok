# Use a base image that includes bash (or the shell you need)
FROM ubuntu:latest

# Copy your script into the container
COPY your_script.sh /app/your_script.sh

# Make the script executable
RUN chmod +x /app/your_script.sh

# Set the working directory (optional, but good practice)
WORKDIR /app

# Run the script when the container starts
CMD ["./your_script.sh"]
