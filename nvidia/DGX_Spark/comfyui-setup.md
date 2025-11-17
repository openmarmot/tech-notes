 # ComfyUI Installation Instructions for NVIDIA DGX Spark

 source : https://build.nvidia.com/spark/comfy-ui/instructions
 
 ## Overview
 ComfyUI is an open-source, node-based GUI for Stable Diffusion and other diffusion models. It runs on Linux systems like the NVIDIA DGX Spark, leveraging the device's unified memory and NVIDIA GPUs for efficient AI image generation and editing workflows. These instructions are based on the official ComfyUI repository and NVIDIA recommendations for DGX Spark.
 
 **Note:** DGX Spark runs Linux, so follow the standard Linux installation. Ensure your DGX Spark is set up with the latest NVIDIA drivers and CUDA toolkit (pre-installed on DGX Spark via NVIDIA AI Software Stack).
 
 ## Prerequisites
 - **Hardware:** NVIDIA DGX Spark with GB10 Grace Blackwell Superchip (includes NVIDIA GPUs and 128GB unified memory).
 - **Software:**
   - Python 3.12 or 3.13 (3.14 supported but may have issues with certain nodes).
   - Git installed.
   - NVIDIA drivers and CUDA (pre-installed on DGX Spark; verify with `nvidia-smi`).
 - **Access:** SSH into your DGX Spark or use NVIDIA Sync for remote access.
 - **Models:** Download Stable Diffusion checkpoints (e.g., SDXL, Flux) and place them in the appropriate directories after installation.
 
 **Verify Prerequisites:**
 ```bash
 # Check Python version
 python --version
 
 # Check Git
 git --version
 
 # Check NVIDIA GPU
 nvidia-smi
 ```
 
 If `nvidia-smi` shows your GPUs, proceed. Otherwise, update your system via NVIDIA's DGX Spark user guide.
 
 ## Installation Steps
 
 ### 1. Set Up a Virtual Environment (Recommended)
 To avoid conflicts with system packages:
 ```bash
 # Install venv if not available
 sudo apt update
 sudo apt install python3-venv
 
 # Create and activate virtual environment
 python -m venv comfyui_env
 source comfyui_env/bin/activate
 ```
 
 ### 2. Install PyTorch for NVIDIA GPUs
 Install the stable CUDA 12.1 version of PyTorch (compatible with DGX Spark):
 ```bash
 pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
 ```
 
 **Alternative (Nightly for Performance Improvements):**
 ```bash
 pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121
 ```
 
 **Troubleshooting PyTorch:**
 If you see "Torch not compiled with CUDA enabled":
 ```bash
 pip uninstall torch torchvision torchaudio
 pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
 ```
 
 ### 3. Clone the ComfyUI Repository
 ```bash
 git clone https://github.com/comfyanonymous/ComfyUI.git
 cd ComfyUI
 ```
 
 ### 4. Install Dependencies
 ```bash
 pip install -r requirements.txt
 ```
 
 ### 5. Download Models
 - Place Stable Diffusion checkpoints (.ckpt or .safetensors) in `ComfyUI/models/checkpoints/`.
 - Place VAE models in `ComfyUI/models/vae/`.
 - Optional: Download additional models (e.g., LoRAs, embeddings) into respective folders like `models/loras/`.
 
 **Example Download (using wget for SDXL base model):**
 ```bash
 mkdir -p models/checkpoints
 cd models/checkpoints
 wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors
 cd ../..
 ```
 
 For Flux or other models, refer to Hugging Face repositories.
 
 ## Running ComfyUI
 
 ### Basic Launch
 ```bash
 # Ensure virtual environment is activated
 source ../comfyui_env/bin/activate  # Adjust path if needed
 
 # Start the server
 python main.py
 ```
 
 - ComfyUI will start a web server at `http://127.0.0.1:8188`.
 - Access it via browser on the same machine or forward ports if remote (e.g., SSH tunneling: `ssh -L 8188:localhost:8188 user@dgx-spark-ip`).
 
 ### Advanced Options
 - **Low VRAM Mode:** `python main.py --lowvram` (useful for testing, though DGX Spark's 128GB unified memory handles large models well).
 - **CPU Offload:** `python main.py --cpu-vae` or `--cpu` for specific nodes.
 - **Multi-GPU:** ComfyUI supports multi-GPU; DGX Spark has two GPUs connectable via NVLink—enable in workflow nodes.
 
 **Default Workflow:**
 - On first run, load a default workflow or create one via the node graph interface.
 - Generate images using diffusion models like SDXL.
 
 ## Configuration and Usage Tips
 - **Unified Memory Utilization:** DGX Spark's architecture allows seamless CPU/GPU memory sharing—load large models (e.g., Flux) without fragmentation.
 - **Workflows:** Save as JSON files for reproducibility. Share via Git or version control.
 - **Updates:** Pull latest changes: `git pull` in the ComfyUI directory, then reinstall dependencies if needed.
 - **Custom Nodes:** Install via ComfyUI-Manager (run `python custom_nodes/ComfyUI-Manager/main.py` after installation).
 
 ## Troubleshooting
 - **CUDA Errors:** Verify PyTorch CUDA: `python -c "import torch; print(torch.cuda.is_available())"`. Should return `True`.
 - **Permission Issues:** Run as non-root; use virtual env.
 - **Port Conflicts:** Change port: `python main.py --port 8189`.
 - **Rollback:** Deactivate venv and delete: `rm -rf comfyui_env ComfyUI`.
 - **Performance:** Monitor with `nvidia-smi`. Expect 3x faster than consumer GPUs like RTX 3070 for SD1.5.
 - **More Help:** Check ComfyUI GitHub issues or NVIDIA Developer Forums for DGX Spark-specific queries.
 
 ## Additional Resources
 - [ComfyUI GitHub](https://github.com/comfyanonymous/ComfyUI)
 - [DGX Spark User Guide](https://docs.nvidia.com/dgx/dgx-spark/index.html)
 - [NVIDIA Build Page](https://build.nvidia.com/spark/comfy-ui)
 
 This setup enables image generation/editing directly on-device. For enterprise scaling, consider NVLink for multi-Spark clusters.
 
 **Last Updated:** November 15, 2025
 ```

