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

# Required model path
# Add arguments if environment variables are set
if [ -n "$SGLANG_MODEL" ]; then
    CMD="$CMD --model $SGLANG_MODEL"
else
    echo "Note: SGLANG_MODEL not set"
fi

# Optional arguments
if [ -n "$SGLANG_TOKENIZER_PATH" ]; then
    CMD="$CMD --tokenizer-path $SGLANG_TOKENIZER_PATH"
fi

if [ -n "$SGLANG_HOST" ]; then
    CMD="$CMD --host $SGLANG_HOST"
fi

if [ -n "$SGLANG_PORT" ]; then
    CMD="$CMD --port $SGLANG_PORT"
else
    echo "Note: SGLANG_PORT not set"
fi

if [ -n "$SGLANG_TOKENIZER_MODE" ]; then
    CMD="$CMD --tokenizer-mode $SGLANG_TOKENIZER_MODE"
fi

if [ -n "$SGLANG_LOAD_FORMAT" ]; then
    CMD="$CMD --load-format $SGLANG_LOAD_FORMAT"
fi

if [ -n "$SGLANG_DTYPE" ]; then
    CMD="$CMD --dtype $SGLANG_DTYPE"
fi

if [ -n "$SGLANG_KV_CACHE_DTYPE" ]; then
    CMD="$CMD --kv-cache-dtype $SGLANG_KV_CACHE_DTYPE"
fi

if [ -n "$SGLANG_QUANTIZATION" ]; then
    CMD="$CMD --quantization $SGLANG_QUANTIZATION"
fi

if [ -n "$SGLANG_CONTEXT_LENGTH" ]; then
    CMD="$CMD --context-length $SGLANG_CONTEXT_LENGTH"
fi

if [ -n "$SGLANG_DEVICE" ]; then
    CMD="$CMD --device $SGLANG_DEVICE"
fi

if [ -n "$SGLANG_MODEL_NAME" ]; then
    CMD="$CMD --served-model-name $SGLANG_MODEL_NAME"
fi

if [ -n "$SGLANG_CHAT_TEMPLATE" ]; then
    CMD="$CMD --chat-template $SGLANG_CHAT_TEMPLATE"
fi

if [ -n "$SGLANG_REVISION" ]; then
    CMD="$CMD --revision $SGLANG_REVISION"
fi

if [ -n "$SGLANG_MEM_FRACTION" ]; then
    CMD="$CMD --mem-fraction-static $SGLANG_MEM_FRACTION"
fi

if [ -n "$SGLANG_MAX_REQUESTS" ]; then
    CMD="$CMD --max-running-requests $SGLANG_MAX_REQUESTS"
fi

if [ -n "$SGLANG_MAX_TOKENS" ]; then
    CMD="$CMD --max-total-tokens $SGLANG_MAX_TOKENS"
fi

if [ -n "$SGLANG_PREFILL_SIZE" ]; then
    CMD="$CMD --chunked-prefill-size $SGLANG_PREFILL_SIZE"
fi

if [ -n "$SGLANG_MAX_PREFILL" ]; then
    CMD="$CMD --max-prefill-tokens $SGLANG_MAX_PREFILL"
fi

if [ -n "$SGLANG_SCHEDULE_POLICY" ]; then
    CMD="$CMD --schedule-policy $SGLANG_SCHEDULE_POLICY"
fi

if [ -n "$SGLANG_SCHEDULE_CONSERVATIVE" ]; then
    CMD="$CMD --schedule-conservativeness $SGLANG_SCHEDULE_CONSERVATIVE"
fi

if [ -n "$SGLANG_CPU_OFFLOAD" ]; then
    CMD="$CMD --cpu-offload-gb $SGLANG_CPU_OFFLOAD"
fi

if [ -n "$SGLANG_TP_SIZE" ]; then
    CMD="$CMD --tensor-parallel-size $SGLANG_TP_SIZE"
fi

# Boolean flags
if [ "$SGLANG_SKIP_TOKENIZER" = "true" ]; then
    CMD="$CMD --skip-tokenizer-init"
fi

if [ "$SGLANG_TRUST_REMOTE_CODE" = "true" ]; then
    CMD="$CMD --trust-remote-code"
fi

if [ "$SGLANG_IS_EMBEDDING" = "true" ]; then
    CMD="$CMD --is-embedding"
fi

if [ "$SGLANG_ENABLE_DP_ATTENTION" = "true" ]; then
    CMD="$CMD --enable-dp-attention"
fi

if [ "$SGLANG_ENABLE_METRICS" = "true" ]; then
    CMD="$CMD --enable-metrics"
fi

if [ "$SGLANG_ENABLE_CACHE_REPORT" = "true" ]; then
    CMD="$CMD --enable-cache-report"
fi

if [ "$SGLANG_ENABLE_TORCH_COMPILE" = "true" ]; then
    CMD="$CMD --enable-torch-compile"
fi

if [ "$SGLANG_DISABLE_FLASHINFER" = "true" ]; then
    CMD="$CMD --disable-flashinfer"
fi

if [ "$SGLANG_DISABLE_DISK_CACHE" = "true" ]; then
    CMD="$CMD --disable-disk-cache"
fi

echo "Launching server with command: $CMD"
exec $CMD
