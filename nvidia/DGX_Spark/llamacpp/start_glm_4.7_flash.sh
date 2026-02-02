#!/bin/bash

# Designed for DGX Spark + GLM-4.7-Flash
# https://unsloth.ai/docs/models/glm-4.7-flash
# https://huggingface.co/unsloth/GLM-4.7-Flash-GGUF
# https://huggingface.co/ggerganov/presets/blob/main/preset.ini

# todo - implement this ?? 
# https://github.com/ggml-org/llama.cpp/pull/19164

# currently running at ~ 42 t/s on DGX Spark 

./llama.cpp/build-cuda/bin/llama-server \
  -hf ggml-org/GLM-4.7-Flash-GGUF:Q8_0 \
  --ctx-size 0 \
  --jinja \
  --temp 1.0 \
  --top-p 0.95 \
  --top-k 0 \
  --min-p 0.01 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  --host 0.0.0.0 \
  --port 8080

