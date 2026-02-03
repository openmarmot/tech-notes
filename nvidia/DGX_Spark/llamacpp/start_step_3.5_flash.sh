

#https://huggingface.co/stepfun-ai/Step-3.5-Flash-Int4

./llama.cpp/build-cuda/bin/llama-server -hf stepfun-ai/Step-3.5-Flash-Int4 --ctx-size 0 --jinja -ub 2048 -b 2048 --host 0.0.0.0 --port 8080