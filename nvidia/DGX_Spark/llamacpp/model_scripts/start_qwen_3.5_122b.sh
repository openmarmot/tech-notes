#!/bin/bash

# note - have not tried this yet

# Designed for DGX Spark

# https://unsloth.ai/docs/models/qwen3.5
# https://huggingface.co/unsloth/Qwen3.5-122B-A10B-GGUF

# -np 1 
# disable unified kv cache which otherwise leads to slow downs over time 
# https://github.com/ggml-org/llama.cpp/discussions/16578#discussioncomment-15726979



# this is using about 87 GB
HF_MODEL="unsloth/Qwen3.5-122B-A10B-GGUF:UD-Q4_K_XL"


./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 0 \
  --temp 1.0 \
  --top-p 0.95 \
  --top-k 20 \
  --min-p 0.01 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  -np 1 \
  --host 0.0.0.0 \
  --port 8080

