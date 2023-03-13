# Use pytorch image with Python 3.8.x
FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel

# Run these before apt-get update for Docker build
# https://github.com/NVIDIA/nvidia-docker/issues/1632#issuecomment-1112667716
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update

RUN apt-get install -y git \
        libsndfile-dev \
        nano \
        wget \
        unzip

RUN conda install -y torchaudio==0.11.0 -c pytorch

# Specify versions for torch/torchaudio in pip install 
# to stop fairseq from upgrading to latest versions
RUN pip install torch==1.11.0 \
    torchaudio==0.11.0 \
    fairseq==0.12.2 \
    tensorboardX==2.5.1 \
    soundfile \
    packaging

WORKDIR /tmp

RUN git clone https://github.com/NVIDIA/apex && \
    cd apex && \
    pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" \
    --global-option="--deprecated_fused_adam" --global-option="--xentropy" \
    --global-option="--fast_multihead_attn" ./

WORKDIR /workspace
