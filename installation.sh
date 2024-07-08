#!/bin/bash
sudo apt update
sudo apt install -y build-essential
 
GRID_DRIVER_URL="https://download.microsoft.com/download/8/d/a/8da4fb8e-3a9b-4e6a-bc9a-72ff64d7a13c/NVIDIA-Linux-x86_64-535.161.08-grid-azure.run"
GRID_DRIVER_FILE="NVIDIA-Linux-x86_64-535.161.08-grid-azure.run"
 
wget $GRID_DRIVER_URL -O $GRID_DRIVER_FILE
sudo chmod +x $GRID_DRIVER_FILE
sudo sh $GRID_DRIVER_FILE
 
CUDA_TOOLKIT_URL="https://developer.download.nvidia.com/compute/cuda/12.2.0/local_installers/cuda_12.2.0_535.54.03_linux.run"
CUDA_TOOLKIT_FILE="cuda_12.2.0_535.54.03_linux.run"
 
wget $CUDA_TOOLKIT_URL -O $CUDA_TOOLKIT_FILE
sudo sh $CUDA_TOOLKIT_FILE --silent --toolkit --override
 
# Set environment variables
echo 'export PATH=$PATH:/usr/local/cuda-12.2/bin' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64' >> ~/.bashrc

# Source the updated bashrc to apply changes
source ~/.bashrc
 
# Verify installations
nvidia-smi
nvcc -V
 
echo "Installation complete. Please reboot and verify that the GRID driver and CUDA toolkit have been installed successfully."

sudo apt-get remove --purge $(dpkg --get-selections | grep -i nvidia | cut -f1)
sudo apt-get remove --purge $(dpkg --get-selections | grep -i cuda | cut -f1)

sed -i PATH="$PATH:/usr/local/cuda-12.2/bin" > 
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64' >> ~/.bashrc

sudo reboot
