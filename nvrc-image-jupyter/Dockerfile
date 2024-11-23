FROM nvcr.io/nvidia/pytorch:23.12-py3

# Use a specific working directory
WORKDIR /app

COPY install_git_and_lfs.sh ./

# Make the git installation script executable and run it
RUN chmod +x install_git_and_lfs.sh && \
    ./install_git_and_lfs.sh

RUN curl https://rclone.org/install.sh |  bash
RUN apt update && apt install gdu btop python3-venv -y && apt autoclean -y && apt autoremove -y
RUN git clone https://github.com/NVIDIA/TensorRT-LLM.git

# Create and activate virtual environment
RUN python -m venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"
ENV VIRTUAL_ENV="/app/.venv"

# Install Python dependencies with version pinning inside virtual environment
RUN . /app/.venv/bin/activate && pip install --no-cache-dir \
    protobuf==4.24.4 \
    SentencePiece==0.1.99 \
    jupyterlab==4.0.9 \
    ipykernel

# Install TensorRT and other dependencies in virtual environment
RUN . /app/.venv/bin/activate && \
    pip install tensorrt_llm -U --pre --extra-index-url https://pypi.nvidia.com && \
    pip install -r TensorRT-LLM/examples/bloom/requirements.txt

# Set up the virtual environment as a Jupyter kernel
RUN . /app/.venv/bin/activate && \
    python -m ipykernel install --name=.venv --display-name="TensorRT-LLM Environment" --sys-prefix

# Copy the rest of the application
COPY . .

# Expose Jupyter and potential service ports
EXPOSE 8888 8000 8001 8002

# Entrypoint script for more flexible configuration
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
