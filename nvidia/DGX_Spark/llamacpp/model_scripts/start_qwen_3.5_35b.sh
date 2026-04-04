#!/bin/bash

# Designed for DGX Spark

# Note that this model seems to require more parameter tuning than i'm used to doing

# https://unsloth.ai/docs/models/qwen3.5
# https://huggingface.co/unsloth/Qwen3.5-35B-A3B-GGUF
# https://huggingface.co/Qwen/Qwen3.5-35B-A3B#best-practices

# -np 1 
# disable unified kv cache which otherwise leads to slow downs over time 
# https://github.com/ggml-org/llama.cpp/discussions/16578#discussioncomment-15726979

# temp and top-p
# i switched to unsloth's recommendation for these for the coding spec.
# the having them higher resulted in excessive thinking

# presence-penalty 
# qwen documentation recommends 0 for programming, but i find that
# it looks uncontrollably with 0. 1 works better

# metrics
# visit /metrics to view.

# --------- Models ----------------------


# used about 40 gb of ram. about 54 t/s. 
# thinking was ultra fast
#HF_MODEL="unsloth/Qwen3.5-35B-A3B-GGUF:UD-Q4_K_XL"

# bigger and slower. not worth it imo
#HF_MODEL="unsloth/Qwen3.5-35B-A3B-GGUF:UD-Q8_K_XL"

# about 50 t/s as of march 10 2026
HF_MODEL="unsloth/Qwen3.5-35B-A3B-GGUF:Q8_0"

# uncensored version
#HF_MODEL=HauhauCS/Qwen3.5-35B-A3B-Uncensored-HauhauCS-Aggressive:Q8_0"

#-----------------------------------------

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 0 \
  --temp 0.6 \
  --top-p 0.95 \
  --top-k 20 \
  --min-p 0.0 \
  --presence-penalty 1.0 \
  --repeat-penalty 1.0 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  -np 1 \
  --no-mmap \
  --jinja \
  --metrics \
  --host 0.0.0.0 \
  --port 8080

