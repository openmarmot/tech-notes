#!/bin/bash

# Designed for DGX Spark

# https://huggingface.co/ggml-org/Clef-Flash-GGUF
# https://huggingface.co/Cloudflare/clef-flash
# llama.cpp/tools/server/README.md  POST /v1/systemone

# 9B decision model, post-trained from Qwen3.5-9B.
# it does not generate text. the server only answers POST /v1/systemone.
# -hf also downloads the mmproj. image input needs it.

# the whole prompt, images included, is one forward pass and must fit in
# --ubatch-size. 16384 is the max_length Cloudflare uses. the physical
# ubatch cannot be larger than the logical batch, so both are set together.
# image tokens are capped to half of --ubatch-size so the text still fits.
# a choice question can have at most 255 options.

# -np 1
# llama-server otherwise picks 4 slots and splits the context across them.
# disable unified kv cache which otherwise leads to slow downs over time
# https://github.com/ggml-org/llama.cpp/discussions/16578#discussioncomment-15726979

# metrics
# visit /metrics to view.

# --------- Models ----------------------

# Q8_0 is about 10 GB
HF_MODEL="ggml-org/Clef-Flash-GGUF:Q8_0"

# repo default, smaller
#HF_MODEL="ggml-org/Clef-Flash-GGUF:Q4_K_M"

# about 18 GB
#HF_MODEL="ggml-org/Clef-Flash-GGUF:BF16"

#-----------------------------------------

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 0 \
  --batch-size 16384 \
  --ubatch-size 16384 \
  -np 1 \
  --metrics \
  --host 0.0.0.0 \
  --port 8089

# example:
# curl http://127.0.0.1:8089/v1/systemone \
#   -H "Content-Type: application/json" \
#   -d '{
#     "state": "Disk on db-02 is at 97% and growing about 1% an hour.",
#     "questions": {
#       "page_oncall": {"type": "noul", "instructions": "Should someone be paged right now?"},
#       "severity": {
#         "type": "score",
#         "instructions": "How severe is this?",
#         "criteria": ["Info", "Minor", "Major", "Critical"]
#       }
#     }
#   }'
