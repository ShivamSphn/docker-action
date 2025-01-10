#!/bin/bash

# Check and login to Hugging Face if token is provided
if [ -n "$HUGGINGFACE_TOKEN" ]; then
    echo "Logging in to Hugging Face..."
    huggingface-cli login --token "$HUGGINGFACE_TOKEN"
else
    echo "Note: HUGGINGFACE_TOKEN not set. Some features might be limited."
fi

# Initialize base command
CMD="python3 -m sglang.launch_server"

# Core model configuration
if [ -n "$SGLANG_MODEL" ]; then
    CMD="$CMD --model $SGLANG_MODEL"
else
    echo "Note: SGLANG_MODEL not set"
fi

# Model loading and format
if [ -n "$LOAD_FORMAT" ]; then
    CMD="$CMD --load-format $LOAD_FORMAT"
fi

# Model context and serving configuration
if [ -n "$CONTEXT_LENGTH" ]; then
    CMD="$CMD --context-length $CONTEXT_LENGTH"
fi

if [ -n "$SERVED_MODEL_NAME" ]; then
    CMD="$CMD --served-model-name $SERVED_MODEL_NAME"
fi

# Performance-critical parameters
if [ -n "$TENSOR_PARALLEL_SIZE" ]; then
    CMD="$CMD --tensor-parallel-size $TENSOR_PARALLEL_SIZE"
fi

if [ -n "$MAX_RUNNING_REQUESTS" ]; then
    CMD="$CMD --max-running-requests $MAX_RUNNING_REQUESTS"
fi

# Optimization and quantization
if [ -n "$QUANTIZATION" ]; then
    CMD="$CMD --quantization $QUANTIZATION"
fi

if [ "$ENABLE_TORCH_COMPILE" = "true" ]; then
    CMD="$CMD --enable-torch-compile"
fi

# Backend selections
if [ -n "$ATTENTION_BACKEND" ]; then
    CMD="$CMD --attention-backend $ATTENTION_BACKEND"
fi

if [ -n "$SAMPLING_BACKEND" ]; then
    CMD="$CMD --sampling-backend $SAMPLING_BACKEND"
fi

if [ -n "$GRAMMAR_BACKEND" ]; then
    CMD="$CMD --grammar-backend $GRAMMAR_BACKEND"
fi

# Performance tuning
if [ -n "$NUM_CONTINUOUS_DECODE_STEPS" ]; then
    CMD="$CMD --num-continuous-decode-steps $NUM_CONTINUOUS_DECODE_STEPS"
fi

if [ -n "$CHUNKED_PREFILL_SIZE" ]; then
    CMD="$CMD --chunked-prefill-size $CHUNKED_PREFILL_SIZE"
fi

# Memory management
if [ -n "$MEM_FRACTION_STATIC" ]; then
    CMD="$CMD --mem-fraction-static $MEM_FRACTION_STATIC"
fi

# Monitoring and reporting
if [ "$ENABLE_CACHE_REPORT" = "true" ]; then
    CMD="$CMD --enable-cache-report"
fi

# Trust remote code if needed
if [ "$TRUST_REMOTE_CODE" = "true" ]; then
    CMD="$CMD --trust-remote-code"
fi

echo "Launching server with command: $CMD"
exec $CMD
