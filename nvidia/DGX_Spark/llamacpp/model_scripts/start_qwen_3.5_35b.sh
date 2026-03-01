#!/bin/bash

# Designed for DGX Spark

# Note I mostly based this off my parameters for the 122b model

# https://unsloth.ai/docs/models/qwen3.5
# https://huggingface.co/unsloth/Qwen3.5-35B-A3B-GGUF

# -np 1 
# disable unified kv cache which otherwise leads to slow downs over time 
# https://github.com/ggml-org/llama.cpp/discussions/16578#discussioncomment-15726979

# temp and top-p
# i switched to unsloth's recommendation for these for the coding spec.
# the having them higher resulted in excessive thinking

# metrics
# visit /metrics to view.

# --------- Models ----------------------


# used about 40 gb of ram. about 54 t/s. 
# thinking was ultra fast
#HF_MODEL="unsloth/Qwen3.5-35B-A3B-GGUF:UD-Q4_K_XL"

# about 58 gb of ram. about 39 t/s
HF_MODEL="unsloth/Qwen3.5-35B-A3B-GGUF:UD-Q8_K_XL"

#-----------------------------------------

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 0 \
  --temp 0.6 \
  --top-p 0.8 \
  --top-k 20 \
  --min-p 0.01 \
  --presence-penalty 1.5 \
  --repeat-penalty 1.0 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  -np 1 \
  --no-mmap \
  --metrics \
  --host 0.0.0.0 \
  --port 8080

