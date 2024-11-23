FROM nvcr.io/nvidia/tritonserver:24.02-trtllm-python-py3

# Use a specific working directory
WORKDIR /app


COPY install_git_and_lfs.sh ./

# Make the git installation script executable and run it
RUN chmod +x install_git_and_lfs.sh && \
    ./install_git_and_lfs.sh
RUN git clone https://github.com/NVIDIA/TensorRT-LLM.git
# Install Python dependencies with version pinning
RUN pip install --no-cache-dir \
    protobuf==4.24.4 \
    SentencePiece==0.1.99 \
    torch==2.1.2 \
    jupyterlab==4.0.9

# Copy the rest of the application
COPY . .

# Expose Jupyter and potential service ports
EXPOSE 8888 8000 8001 8002

# Entrypoint script for more flexible configuration
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
