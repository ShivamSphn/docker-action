#!/bin/bash

# Check if JUPYTER_TOKEN is set, otherwise require user input
if [ -z "$JUPYTER_TOKEN" ]; then
    echo "Error: JUPYTER_TOKEN must be set for security reasons."
    echo "Run the container with: -e JUPYTER_TOKEN=your_secure_token"
    exit 1
fi

# Activate virtual environment
source /app/.venv/bin/activate

# Set virtual environment as default kernel
jupyter kernelspec list
python -m ipykernel install --user --name=.venv --display-name="TensorRT-LLM Environment" --sys-prefix

# Start Jupyter Lab with the provided token
exec jupyter lab \
    --LabApp.token="$JUPYTER_TOKEN" \
    --LabApp.ip='0.0.0.0' \
    --LabApp.allow_root=True \
    --LabApp.default_kernel_name=.venv
