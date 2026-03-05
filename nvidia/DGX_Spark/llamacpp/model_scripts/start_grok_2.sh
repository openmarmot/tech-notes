#!/bin/bash

# Designed for DGX Spark

# 

# https://unsloth.ai/docs/models/tutorials/grok-2
# https://huggingface.co/unsloth/grok-2-GGUF

# -np 1 
# disable unified kv cache which otherwise leads to slow downs over time 
# https://github.com/ggml-org/llama.cpp/discussions/16578#discussioncomment-15726979


# metrics
# visit /metrics to view.

# --------- Models ----------------------

# slightly too big for one spark. 
#HF_MODEL="unsloth/grok-2-GGUF:Q2_K_XL"

HF_MODEL="unsloth/grok-2-GGUF:Q2_K_L"

#-----------------------------------------

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 0 \
  --temp 1.0 \
  --top-p 0.95 \
  --min-p 0.01 \
  -np 1 \
  --no-mmap \
  --metrics \
  --host 0.0.0.0 \
  --port 8080

