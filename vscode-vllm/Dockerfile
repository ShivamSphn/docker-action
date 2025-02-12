# Start with NVIDIA CUDA base image
FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    curl \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && which python3 \
    && which pip3 \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && ln -sf /usr/bin/pip3 /usr/bin/pip

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create a non-root user
RUN useradd -m -s /bin/bash coder && \
    mkdir -p /etc/sudoers.d && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd && \
    chmod 440 /etc/sudoers.d/nopasswd

# Install PyTorch with CUDA support
# RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set environment variables
ENV PUID=0
ENV PGID=0
ENV TZ=Etc/UTC
ENV PASSWORD=Hello2us@
ENV DEFAULT_WORKSPACE=/config/workspace

# Update user permissions to match PUID/PGID
RUN groupmod -o -g $PGID coder && \
    usermod -o -u $PUID coder && \
    mkdir -p /config/workspace && \
    chown -R coder:coder /config

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Switch to non-root user
USER coder
WORKDIR ${DEFAULT_WORKSPACE}

# Expose code-server port
EXPOSE 8080
EXPOSE 8000

# Start code-server with password authentication
CMD ["sh", "-c", "code-server --bind-addr 0.0.0.0:8080 --auth password"] 