
# LLM Server Deployment Configuration

This document describes the key environment variables used to configure the LLM server deployment.

## Core Configuration

### Model Settings
| Environment Variable | Description | Default | Options |
|---------------------|-------------|---------|----------|
| `SGLANG_MODEL` | Model identifier/path | Required | Any HF model ID or local path |
| `LOAD_FORMAT` | Model loading format | `auto` | `auto`, `pt`, `safetensors`, `npcache`, `gguf`, `bitsandbytes` |
| `CONTEXT_LENGTH` | Maximum context window | Model default | Integer value |
| `SERVED_MODEL_NAME` | Model name for API | Model default | Any string |

### Performance Optimization

#### Parallelization & Throughput
| Environment Variable | Description | Default | Options |
|---------------------|-------------|---------|----------|
| `TENSOR_PARALLEL_SIZE` | GPU parallel size | `1` | Integer value |
| `MAX_RUNNING_REQUESTS` | Concurrent requests | System dependent | Integer value |

#### Model Optimization
| Environment Variable | Description | Default | Options |
|---------------------|-------------|---------|----------|
| `QUANTIZATION` | Model quantization method | None | `awq`, `fp8`, `gptq`, `marlin`, `gptq_marlin`, `awq_marlin`, `bitsandbytes`, `gguf` |
| `ENABLE_TORCH_COMPILE` | Enable PyTorch 2.0 compilation | `false` | `true`/`false` |

#### Backend Selection
| Environment Variable | Description | Default | Options |
|---------------------|-------------|---------|----------|
| `ATTENTION_BACKEND` | Attention implementation | `flashinfer` | `flashinfer`, `triton`, `torch_native` |
| `SAMPLING_BACKEND` | Sampling implementation | `flashinfer` | `flashinfer`, `pytorch` |
| `GRAMMAR_BACKEND` | Grammar-guided decoding | `xgrammar` | `xgrammar`, `outlines` |

### Performance Tuning
| Environment Variable | Description | Default | Options |
|---------------------|-------------|---------|----------|
| `NUM_CONTINUOUS_DECODE_STEPS` | Batch decode steps | `1` | Integer value |
| `CHUNKED_PREFILL_SIZE` | Prefill batch size | System dependent | Integer value |
| `MEM_FRACTION_STATIC` | Static memory fraction | System dependent | Float (0-1) |

### Monitoring & Security
| Environment Variable | Description | Default | Options |
|---------------------|-------------|---------|----------|
| `ENABLE_CACHE_REPORT` | Enable cache metrics | `false` | `true`/`false` |
| `TRUST_REMOTE_CODE` | Allow custom model code | `false` | `true`/`false` |
| `HUGGINGFACE_TOKEN` | HF API token | None | Valid HF token |

## Usage Example

```bash
docker run -e SGLANG_MODEL="mistralai/Mistral-7B-v0.1" \
           -e TENSOR_PARALLEL_SIZE=2 \
           -e QUANTIZATION="awq" \
           -e ENABLE_TORCH_COMPILE=true \
           -e MAX_RUNNING_REQUESTS=32 \
           -e CONTEXT_LENGTH=4096 \
           -e ATTENTION_BACKEND="flashinfer" \
           your-image-name
```

## Performance Recommendations

### High Throughput Setup
```bash
-e TENSOR_PARALLEL_SIZE=4 \
-e MAX_RUNNING_REQUESTS=64 \
-e QUANTIZATION="awq" \
-e ENABLE_TORCH_COMPILE=true \
-e NUM_CONTINUOUS_DECODE_STEPS=2
```

### Low Latency Setup
```bash
-e TENSOR_PARALLEL_SIZE=2 \
-e MAX_RUNNING_REQUESTS=16 \
-e ATTENTION_BACKEND="flashinfer" \
-e SAMPLING_BACKEND="flashinfer" \
-e ENABLE_TORCH_COMPILE=true
```

### Memory Optimized Setup
```bash
-e QUANTIZATION="awq" \
-e MEM_FRACTION_STATIC=0.9 \
-e LOAD_FORMAT="safetensors"
```

## Notes

- Adjust `TENSOR_PARALLEL_SIZE` based on available GPUs
- `QUANTIZATION` choice affects memory usage and inference speed
- `CONTEXT_LENGTH` affects memory usage significantly
- Enable `ENABLE_CACHE_REPORT` for performance monitoring
- Use `TRUST_REMOTE_CODE` with caution in production

## Requirements

- CUDA-compatible GPUs
- Docker with GPU support
- Sufficient GPU memory for model and parallelization
