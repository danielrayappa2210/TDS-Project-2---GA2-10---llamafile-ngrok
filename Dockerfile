FROM debian:bookworm-slim

# Install necessary tools
RUN apt update && apt install -y wget curl ca-certificates iputils-ping net-tools

# Check if we have internet access within the container
RUN ping -c 4 google.com || (echo "Network issue" && exit 1)

# Attempt to download the file (curl without SSL bypass)
RUN curl -L -o /app/llama.llamafile "https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile"

# Make the Llamafile executable
RUN chmod +x /app/llama.llamafile

# Expose Railway's assigned port dynamically
EXPOSE $PORT

# Run the Llamafile server on the assigned port
CMD ["/app/llama.llamafile", "--server", "--host", "0.0.0.0", "--port", "$PORT"]
