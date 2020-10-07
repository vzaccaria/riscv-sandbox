FROM    ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/zsh
ENTRYPOINT /bin/zsh

RUN apt-get update && apt-get install -y locales

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "retry n. 1"
RUN apt-get update 

RUN apt-get install -y \
    curl \
    wget \
    zsh \
    stow \
    git \
    libglu1-mesa \
    ispell \
    screen \
    silversearcher-ag \
    software-properties-common \
    llvm-3.5 \
    llvm-3.5-dev \
    clang-3.5 \
    tmux \
    unzip \
    nodejs \
    build-essential \
    autoconf \
    automake \
    python-dev \
    libtool \
    pkg-config \
    libssl-dev \
    vim



RUN apt-get install -y autoconf automake autotools-dev curl \
    libmpc-dev libmpfr-dev libgmp-dev gawk build-essential \
    bison flex texinfo gperf libtool patchutils bc zlib1g-dev
WORKDIR /root
RUN git clone https://github.com/riscv/riscv-gnu-toolchain.git
WORKDIR /root/riscv-gnu-toolchain
RUN git submodule update --init --recursive


RUN ./configure --prefix=/opt/riscv/toolchain
RUN make
RUN make install
WORKDIR /root
RUN git clone https://github.com/rv8-io/rv8.git
WORKDIR /root/rv8
RUN git submodule update --init --recursive
RUN make
RUN make install


