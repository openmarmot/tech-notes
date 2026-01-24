# rebuild llama.cpp 
# designed for the spark or other cuda devices 
# llama.cpp is fastly evolving so I like to do a fresh rebuild often
# this is simpler than doing a git pull as you also want to clean out any build files 

#!/bin/bash

# Remove existing llama.cpp directory if it exists
if [ -d "llama.cpp" ]; then
    echo "Removing existing llama.cpp directory..."
    rm -rf llama.cpp
fi

# Clone the repository
echo "Cloning https://github.com/ggml-org/llama.cpp ..."
git clone https://github.com/ggml-org/llama.cpp

# Enter the directory
cd llama.cpp

# Configure the CUDA build
echo "Configuring build with CUDA support..."
cmake -B build-cuda -DGGML_CUDA=ON

# Build in parallel
echo "Building..."
cmake --build build-cuda -j