FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

ENV DISTR buster
ENV CXXFLAGS "-Wno-error=stringop-truncation"
ARG BOOST_VER=72
ARG CMAKE_VER="3.17.3"

RUN apt-get update && apt-get install -y \
    libmariadb-dev-compat \
    libexpat-dev \
    libpq-dev \
    unixodbc-dev \
    flex \
    bison \
    git \
    build-essential \
    libjemalloc-dev \
    libssl-dev \
    wget \
    ca-certificates \
&& rm -rf /var/lib/apt/lists/*

RUN cd / && wget https://dl.min.io/client/mc/release/linux-amd64/mc \
    && chmod +x mc && mv mc /usr/local/bin/ && mc update

RUN wget https://dl.bintray.com/boostorg/release/1.${BOOST_VER}.0/source/boost_1_${BOOST_VER}_0.tar.gz \
    && tar -zxf boost_1_${BOOST_VER}_0.tar.gz && rm boost_1_${BOOST_VER}_0.tar.gz \
    && cd boost_1_${BOOST_VER}_0 \
    && ./bootstrap.sh \
    && ./b2 install  --with-context --with-system runtime-link=static \
    && cd .. && rm -rf boost_1_${BOOST_VER}_0

RUN cd / \
    && wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.tar.gz \
    && tar -zxf cmake-${CMAKE_VER}-Linux-x86_64.tar.gz \
    && rm cmake-${CMAKE_VER}-Linux-x86_64.tar.gz

ENV PATH $PATH:/cmake-${CMAKE_VER}-Linux-x86_64/bin

CMD ["/bin/sh", "-c", "mkdir -p /manticore/build && cd /manticore/build && cmake -DPACK=1 /manticore && make -j4 package"]