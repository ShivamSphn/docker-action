#!/bin/bash

# Check and login to Hugging Face if token is provided
if [ -n "$HUGGINGFACE_TOKEN" ]; then
    echo "Logging in to Hugging Face..."
    huggingface-cli login --token "$HUGGINGFACE_TOKEN"
else
    echo "Note: HUGGINGFACE_TOKEN not set. Some features might be limited."
fi

# Virtual environment activation (commented out)
# source /app/.venv/bin/activate

# Initialize base command
CMD="python3 -m sglang.launch_server"

# Add arguments if environment variables are set
if [ -n "$SGLANG_MODEL" ]; then
    CMD="$CMD --model $SGLANG_MODEL"
else
    echo "Note: SGLANG_MODEL not set"
fi

if [ -n "$SGLANG_TP" ]; then
    CMD="$CMD --tp $SGLANG_TP"
else
    echo "Note: SGLANG_TP not set"
fi

if [ -n "$SGLANG_PORT" ]; then
    CMD="$CMD --port $SGLANG_PORT"
else
    echo "Note: SGLANG_PORT not set"
fi

if [ "$SGLANG_ENABLE_DP_ATTENTION" = "true" ]; then
    CMD="$CMD --enable-dp-attention"
fi

if [ "$SGLANG_TRUST_REMOTE_CODE" = "true" ]; then
    CMD="$CMD --trust-remote-code"
fi

echo "Launching sglang server with command: $CMD"
exec $CMD
