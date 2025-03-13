FROM debian:bookworm-slim

# Install necessary tools
RUN apt update && apt install -y wget curl ca-certificates

# Check internet access (before attempting download)
RUN wget -q --spider https://www.google.com || (echo "No internet access" && exit 1)

# Debug the URL by trying to download the file and log any errors
RUN curl -v -L -o /app/llama.llamafile "https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile" || (echo "Download failed after retries" && exit 1)

# Make the Llamafile executable
RUN chmod +x /app/llama.llamafile

# Expose Railway's assigned port dynamically
EXPOSE $PORT

# Run the Llamafile server on the assigned port
CMD ["/app/llama.llamafile", "--server", "--host", "0.0.0.0", "--port", "$PORT"]
