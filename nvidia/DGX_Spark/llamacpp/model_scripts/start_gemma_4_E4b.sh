#!/bin/bash

# Designed for DGX Spark

# https://huggingface.co/unsloth/gemma-4-E4B-it-GGUF
# https://unsloth.ai/docs/models/gemma-4

# -np 1
# disable unified kv cache which otherwise leads to slow downs over time
# https://github.com/ggml-org/llama.cpp/discussions/16578#discussioncomment-15726979


# metrics
# visit /metrics to view.

# --------- Models ----------------------



#
HF_MODEL="unsloth/gemma-4-E4B-it-GGUF:Q8_0"

# uncensored version
#HF_MODEL=HauhauCS/Qwen3.5-35B-A3B-Uncensored-HauhauCS-Aggressive:Q8_0"

#-----------------------------------------

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 0 \
  --temp 1 \
  --top-p 0.95 \
  --top-k 64 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  -np 1 \
  --no-mmap \
  --metrics \
  --host 0.0.0.0 \
  --port 8080
