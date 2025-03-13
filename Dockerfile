FROM debian:bookworm-slim

# Install necessary tools
RUN apt update && apt install -y wget curl ca-certificates

# Test downloading the file with curl (basic version without retries or verbosity)
RUN curl -L -o /app/llama.llamafile "https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile" || (echo "Download failed" && exit 1)

# Make the Llamafile executable
RUN chmod +x /app/llama.llamafile

# Expose Railway's assigned port dynamically
EXPOSE $PORT

# Run the Llamafile server on the assigned port
CMD ["/app/llama.llamafile", "--server", "--host", "0.0.0.0", "--port", "$PORT"]
