FROM debian:bookworm-slim  

# Install necessary tools
RUN apt update && apt install -y wget curl  

# Download and set up the Llamafile
RUN wget -O /app/llama.llamafile "https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile" \
    && chmod +x /app/llama.llamafile  

# Expose Railway's assigned port dynamically
EXPOSE $PORT  

# Run the Llamafile server on the assigned port
CMD ["/app/llama.llamafile", "--server", "--host", "0.0.0.0", "--port", "$PORT"]
