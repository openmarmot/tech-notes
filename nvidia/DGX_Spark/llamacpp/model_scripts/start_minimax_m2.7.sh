
# minimax m 2.7
#  note (on release) the license prohibits commercial use

# https://unsloth.ai/docs/models/minimax-m27
# https://huggingface.co/unsloth/MiniMax-M2.7-GGUF

HF_MODEL="unsloth/MiniMax-M2.7-GGUF:UD-IQ4_XS"

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 16384 \
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
