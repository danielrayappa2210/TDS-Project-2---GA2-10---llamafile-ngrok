FROM debian:bookworm-slim AS builder

WORKDIR /llama_app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    vim \
    ca-certificates && \
    wget https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile -O llama.llamafile && \
    chmod +x llama.llamafile && \
    apt-get purge -y --auto-remove wget && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /usr/share/doc/* /usr/share/man/*

FROM debian:bookworm-slim

WORKDIR /llama_app

COPY --from=builder /llama_app/llama.llamafile .

RUN apt-get update -y
RUN apt-get install -y python3 python3-pip
RUN pip3 install fastapi
RUN pip3 install uvicorn
RUN pip3 install requests
RUN pip3 install Jinja2

COPY app.py .
COPY templates ./templates

EXPOSE 9090
EXPOSE 8000

CMD ["python3", "app.py"]
