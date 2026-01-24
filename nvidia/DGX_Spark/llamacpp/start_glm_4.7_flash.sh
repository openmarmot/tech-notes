# designed for the dgx spark 
# https://unsloth.ai/docs/models/glm-4.7-flash
# https://huggingface.co/unsloth/GLM-4.7-Flash-GGUF

./llama.cpp/build-cuda/bin/llama-server -hf unsloth/GLM-4.7-Flash-GGUF:UD-Q8_K_XL --ctx-size 0 --jinja --temp 1.0 --top-p 0.95 --min-p 0.01 --fit on --host 0.0.0.0 --port 8080
