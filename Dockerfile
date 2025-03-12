# Use a lightweight base image
FROM debian:bookworm-slim 

# Set working directory
WORKDIR /app

# Install required dependencies
RUN apt update && apt install -y wget curl && rm -rf /var/lib/apt/lists/*

# Download the Llamafile and make it executable
RUN wget -O /app/llava.llamafile "https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile" && \
    chmod +x /app/llava.llamafile

# Expose the port used by the llamafile server
EXPOSE 8000

# Start the Llamafile on container run
CMD ["/app/llava.llamafile", "--server", "--host", "0.0.0.0", "--port", "8000"]
