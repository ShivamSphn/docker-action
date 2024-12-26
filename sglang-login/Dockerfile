FROM lmsysorg/sglang:dev 
WORKDIR /app
COPY install_git_and_lfs.sh ./
# Make the git installation script executable and run it
RUN chmod +x install_git_and_lfs.sh && \
    ./install_git_and_lfs.sh

RUN curl https://rclone.org/install.sh |  bash

RUN apt update && apt install python3-venv -y && apt autoclean -y && apt autoremove -y

# Virtual environment setup (commented out)
# RUN python -m venv /app/.venv
# ENV PATH="/app/.venv/bin:$PATH"
# ENV VIRTUAL_ENV="/app/.venv"

# Install Python dependencies with version pinning
RUN pip install --no-cache-dir \
    protobuf==4.24.4 \
    SentencePiece==0.1.99 \
    "huggingface_hub[cli]"
# Expose port (will be configured via environment variable)
EXPOSE ${SGLANG_PORT}

# Entrypoint script for configuration
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
