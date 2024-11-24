# docker-action

This repository contains Docker images for Jupyter environments with different configurations.

## Available Images

### NVRC Jupyter
```bash
# Latest version
docker pull shivamsphn/nvrc-jupyter:latest

# Specific date version (YYYYMMDD format)
docker pull shivamsphn/nvrc-jupyter:v20241123

# Specific commit version
docker pull shivamsphn/nvrc-jupyter:vf93210a
```

### Triton Jupyter
```bash
# Latest version
docker pull shivamsphn/triton-jupyter:latest

# Specific date version (YYYYMMDD format)
docker pull shivamsphn/triton-jupyter:v20241123

# Specific commit version
docker pull shivamsphn/triton-jupyter:vf93210a
```

## Versioning System

Each image is tagged with three different versions:

1. **Latest Tag** (`latest`)
   - Always points to the most recent build
   - Use this if you always want the newest version
   - Example: `shivamsphn/nvrc-jupyter:latest`

2. **Date Tag** (`vYYYYMMDD`)
   - Indicates when the image was built
   - Useful for tracking image age and updates
   - Example: `shivamsphn/nvrc-jupyter:v20241123`

3. **Commit Tag** (`v<sha>`)
   - Based on the Git commit SHA
   - Provides exact traceability to source code
   - Example: `shivamsphn/nvrc-jupyter:vf93210a`

## Usage

### Required Environment Variables

- `JUPYTER_TOKEN`: Required for security. Set this to a secure token of your choice.
- `HUGGINGFACE_TOKEN`: Required for Hugging Face model access. Set this to your Hugging Face API token.

### Running the Containers

To use a specific version of an image:

```bash
# Run the latest version
docker run -it \
    -e JUPYTER_TOKEN=your_secure_token \
    -e HUGGINGFACE_TOKEN=your_huggingface_token \
    -p 8888:8888 -p 8000:8000 -p 8001:8001 -p 8002:8002 \
    shivamsphn/nvrc-jupyter:latest

# Run a specific date version
docker run -it \
    -e JUPYTER_TOKEN=your_secure_token \
    -e HUGGINGFACE_TOKEN=your_huggingface_token \
    -p 8888:8888 -p 8000:8000 -p 8001:8001 -p 8002:8002 \
    shivamsphn/nvrc-jupyter:v20241123

# Run a specific commit version
docker run -it \
    -e JUPYTER_TOKEN=your_secure_token \
    -e HUGGINGFACE_TOKEN=your_huggingface_token \
    -p 8888:8888 -p 8000:8000 -p 8001:8001 -p 8002:8002 \
    shivamsphn/nvrc-jupyter:vf93210a
```

### Accessing Jupyter Lab

After running the container, access Jupyter Lab at:
```
http://localhost:8888?token=your_secure_token
```

Make sure to replace `your_secure_token` with the actual token you provided in the JUPYTER_TOKEN environment variable.

## Port Mappings

The following ports are exposed:
- 8888: Jupyter Lab interface
- 8000, 8001, 8002: Additional service ports

## Version Selection Guide

- Use `latest` for development and testing
- Use date tags (`v20241123`) for stable production deployments
- Use commit tags (`vf93210a`) when you need exact version control or debugging

## Security Note

- Always set a secure JUPYTER_TOKEN when running the containers. Never use default or easily guessable tokens in production environments.
- The HUGGINGFACE_TOKEN should be kept secure and not shared publicly. This token is used to authenticate with Hugging Face's model hub and is automatically configured during container startup.
