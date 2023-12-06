#!/bin/zsh

echo "did you download cudnn to $HOME/Downloads and name it as 'cudnn'"
read -p "[Y/n]" confirm

if [ "$confirm" = 'y' ]; then
  echo "you have confirmed that cudnn is inside $HOME/Downloads and named as cudnn"
  if [ -d $HOME/Downloads/cudnn ]; then
    echo "found cudnn"
    sudo cp cudnn/include/cudnn*.h /usr/local/cuda-11.8/include
    sudo cp -P cudnn/lib/libcudnn* /usr/local/cuda-11.8/lib64
    sudo chmod a+r /usr/local/cuda-11.8/include/cudnn*.h /usr/local/cuda-11.8/lib64/libcudnn*
    sudo apt update
    echo "cudnn done"
  else
    echo "no cudnn download it please"
  fi
else
  echo "Cudnn is not downloaded"
fi

echo "Downloading Cuda"
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
echo "Download Completed"
echo "Installing Cuda, Please approve if needed"
sudo sh cuda_11.8.0_520.61.05_linux.run
echo "Install completed"

echo "CUDA/CUDNN setup COMPLETEd"
echo "Installing Tensorflow"
pip install --extra-index-url https://pypi.nvidia.com tensorrt-bindings==8.6.1 tensorrt-libs==8.6.1
pip install -U tensorflow[and-cuda]
echo "Tensorflow Install Completed"

echo "Verify Tensorflow"
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
