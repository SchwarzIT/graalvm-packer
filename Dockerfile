FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean
RUN apt-get update

RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    build-essential \
    libz-dev \
    bash \
    zlib1g-dev \
    gnupg-agent \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

ENV DOCKER_COMPOSE_VERSION 1.26.2
RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

WORKDIR /opt

ENV MVN_VERSION 3.6.3
ENV GRAAL_VERSION 20.1.0
ENV M2_HOME /opt/maven
ENV GRAALVM_HOME /opt/graalvm-ce-java11-20.1.0
ENV JAVA_HOME ${GRAALVM_HOME}
ENV PATH ${GRAALVM_HOME}/bin:${M2_HOME}/bin:${PATH}

RUN wget -nv https://apache.mirrors.nublue.co.uk/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz
RUN tar zxvf apache-maven-${MVN_VERSION}-bin.tar.gz
RUN ln -s apache-maven-${MVN_VERSION} maven

RUN wget -nv https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-java11-linux-amd64-${GRAAL_VERSION}.tar.gz
RUN tar zxvf graalvm-ce-java11-linux-amd64-${GRAAL_VERSION}.tar.gz

RUN update-alternatives --install /usr/bin/java java ${GRAALVM_HOME}/bin/java  3
RUN java --version

RUN gu install native-image
