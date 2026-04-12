# designed for the nvidia dgx spark

./llama.cpp/build-cuda/bin/llama-server -hf ggml-org/gpt-oss-120b-GGUF --ctx-size 0 --jinja -ub 2048 -b 2048 --host 0.0.0.0 --port 8080