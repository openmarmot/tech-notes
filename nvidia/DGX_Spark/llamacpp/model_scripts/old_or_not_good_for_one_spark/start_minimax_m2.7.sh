
# !!! Note that this is likely to exceeed your memory for 1x spark
# probably best to try a q3
# however I don't think this is a good model for one spark so I'm not developing it further.


# minimax m 2.7
#  note (on release) the license prohibits commercial use

# https://unsloth.ai/docs/models/minimax-m27
# https://huggingface.co/unsloth/MiniMax-M2.7-GGUF

# !! uses 121gb of ram at 50k context. basically the absolute max.
# you may need to trim context or go to a smaller quant
# ~ 14 t/s
HF_MODEL="unsloth/MiniMax-M2.7-GGUF:UD-IQ4_XS"

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 50000 \
  --jinja \
  --temp 1.0 \
  --top-p 0.95 \
  --top-k 40 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  -np 1 \
  --no-mmap \
  --host 0.0.0.0 \
  --port 8080
