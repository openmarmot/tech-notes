#!/bin/bash

# Designed to run on a DGX Spark
# Feb 2026 release
# https://huggingface.co/Qwen/Qwen3-Coder-Next-GGUF/tree/main
# https://huggingface.co/unsloth/Qwen3-Coder-Next-GGUF
# https://unsloth.ai/docs/models/qwen3-coder-next

./llama.cpp/build-cuda/bin/llama-server \
  -hf unsloth/Qwen3-Coder-Next-GGUF:Q8_0 \
  --ctx-size 0 \
  --jinja \
  --temp 1.0 \
  --top-p 0.95 \
  --top-k 40 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  --host 0.0.0.0 \
  --port 8080

