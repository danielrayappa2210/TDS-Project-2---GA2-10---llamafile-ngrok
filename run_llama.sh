#!/bin/bash

# Download llama.llamafile
wget https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile -O llama.llamafile
chmod +x llama.llamafile

# Check CPU Architecture
echo "CPU Architecture:"
lscpu | grep "Architecture:"
# OR you can use
# uname -m

# Run llama.cpp server
./llama.llamafile --server --host 0.0.0.0 --port 8000 --parallel 2
