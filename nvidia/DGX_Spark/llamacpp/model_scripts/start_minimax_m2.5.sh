
# note - have not tried this yet.
# seems a bit oversized for one spark and im 
# suspicious of heavy quants 

# https://forums.developer.nvidia.com/t/minimax-2-5-on-dgx-spark-thanks-to-unsloth-https-unsloth-ai-docs-models-minimax-2-5/360663/5
# https://unsloth.ai/docs/models/minimax-m25

HF_MODEL="unsloth/MiniMax-M2.5-GGUF:UD-Q3_K_XL"

./llama.cpp/build-cuda/bin/llama-server \
  -hf "$HF_MODEL" \
  --ctx-size 16384 \
  --jinja \
  --temp 1.0 \
  --top-p 0.95 \
  --top-k 40 \
  --min-p 0.01 \
  --batch-size 4096 \
  --ubatch-size 4096 \
  -np 1 \
  --host 0.0.0.0 \
  --port 8080
