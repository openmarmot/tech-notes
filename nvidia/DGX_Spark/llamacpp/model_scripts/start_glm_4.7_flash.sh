#!/bin/bash

# Designed for DGX Spark + GLM-4.7-Flash
# https://unsloth.ai/docs/models/glm-4.7-flash

# https://huggingface.co/ggerganov/presets/blob/main/preset.ini
# https://huggingface.co/noctrex/GLM-4.7-Flash-MXFP4_MOE-GGUF

# model sources 
# https://huggingface.co/unsloth/GLM-4.7-Flash-GGUF
# https://huggingface.co/noctrex/GLM-4.7-Flash-MXFP4_MOE-GGUF

# todo - implement this ?? 
# https://github.com/ggml-org/llama.cpp/pull/19164

# currently running at ~ 42 t/s on DGX Spark 

# this is fantastic, but slows down a lot at higher context
#HF_MODEL="ggml-org/GLM-4.7-Flash-GGUF:Q8_0"

# MXFP4 is generally highly regarded. faster, but at what cost?
HF_MODEL="noctrex/GLM-4.7-Flash-MXFP4_MOE-GGUF:MXFP4_MOE"


# -np 1 
# disable unified kv cache which otherwise leads to slow downs over time 
# https://github.com/ggml-org/llama.cpp/discussions/16578#discussioncomment-15726979

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 0 \
  --jinja \
  --temp 1.0 \
  --top-p 0.95 \
  --top-k 0 \
  --min-p 0.01 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  -np 1 \
  --host 0.0.0.0 \
  --port 8080

