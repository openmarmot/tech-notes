#!/bin/bash

# Designed for DGX Spark

https://unsloth.ai/docs/models/nemotron-3-super
https://huggingface.co/unsloth/NVIDIA-Nemotron-3-Super-120B-A12B-GGUF
https://huggingface.co/ggml-org/Nemotron-3-Super-120B-GGUF


# -np 1 
# disable unified kv cache which otherwise leads to slow downs over time 
# https://github.com/ggml-org/llama.cpp/discussions/16578#discussioncomment-15726979


# metrics
# visit /metrics to view.

# --------- Models ----------------------




# this was too big at full context
#HF_MODEL="unsloth/NVIDIA-Nemotron-3-Super-120B-A12B-GGUF:UD-Q4_K_M"

# this fits at full 1 million context. running at about 13 t/s
HF_MODEL="ggml-org/Nemotron-3-Super-120B-GGUF"

#-----------------------------------------

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 0 \
  --temp 0.6 \
  --top-p 0.95 \
  --min-p 0.01 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  -np 1 \
  --no-mmap \
  --jinja \
  --metrics \
  --host 0.0.0.0 \
  --port 8080

