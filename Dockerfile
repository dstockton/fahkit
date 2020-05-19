FROM nvidia/cuda:10.0-cudnn7-runtime

ARG VERSION="v7.6"

ENV DEBIAN_FRONTEND=noninteractive

ENV USER "daveys110"
ENV TEAM "279321"
ENV ENABLE_GPU "true"
ENV ENABLE_SMP "true"
ENV POWER "full"

EXPOSE 7396

RUN set -ex \
  && apt update \
  && apt upgrade -y \
  && apt update \
  && apt install -y \
    bzip2 \
    software-properties-common \
    tzdata \
    wget \
  && add-apt-repository -y ppa:graphics-drivers \
  && apt install -y \
    nvidia-opencl-dev \
  && useradd --system folding \
  && mkdir -p /opt/fahclient \
  && wget https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/${VERSION}/latest.tar.bz2 -O /tmp/fahclient.tar.bz2 \
  && tar -xjf /tmp/fahclient.tar.bz2 -C /opt/fahclient --strip-components=1 \
  && wget https://apps.foldingathome.org/GPUs.txt -O /opt/fahclient/GPUs.txt \
  && chown -R folding:folding /opt/fahclient \
  && rm -rf /tmp/fahclient.tar.bz2 \
  && apt remove -y software-properties-common \
  && apt autoremove -y \
  && apt clean autoclean \
  && rm -rf /var/lib/apt/lists/*
