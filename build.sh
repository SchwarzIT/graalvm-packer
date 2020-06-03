#!/bin/sh

apt-get clean
apt-get update

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    bash \
    build-essential \
    libz-dev \
    zlib1g-dev

cd /opt

wget -nv https://apache.mirrors.nublue.co.uk/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar zxvf apache-maven-3.6.3-bin.tar.gz
ln -s apache-maven-3.6.3 maven


export M2_HOME=/opt/maven
export GRAALVM_HOME=/opt/graalvm-ce-java11-20.0.0
export PATH=$GRAALVM_HOME/bin:$M2_HOME/bin:$PATH


wget -nv https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.0.0/graalvm-ce-java11-linux-amd64-20.0.0.tar.gz
tar zxvf graalvm-ce-java11-linux-amd64-20.0.0.tar.gz

update-alternatives --install /usr/bin/java java $GRAALVM_HOME/bin/java  3
java --version

gu install native-image

