#!/bin/bash

apt-get clean
apt-get update

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    build-essential \
    libz-dev \
    bash \
    zlib1g-dev

cd /opt

MVN_VERSION=3.6.3
GRAALVM_VERSION=20.1.0

wget -nv https://apache.mirrors.nublue.co.uk/maven/maven-3/$MVN_VERSION/binaries/apache-maven-$MVN_VERSION-bin.tar.gz
tar zxvf apache-maven-$MVN_VERSION-bin.tar.gz
ln -s apache-maven-$MVN_VERSION maven

export M2_HOME=/opt/maven
export GRAALVM_HOME=/opt/graalvm-ce-java11-$GRAALVM_VERSION
export PATH=$GRAALVM_HOME/bin:$M2_HOME/bin:$PATH

wget -nv https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-java11-linux-amd64-$GRAALVM_VERSION.tar.gz
tar zxvf graalvm-ce-java11-linux-amd64-$GRAALVM_VERSION.tar.gz

update-alternatives --install /usr/bin/java java $GRAALVM_HOME/bin/java  3
java --version

gu install native-image

