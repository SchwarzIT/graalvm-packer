FROM buildpack-deps:buster-scm

RUN apt-get clean
RUN apt-get update

RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    build-essential \
    libz-dev \
    zlib1g-dev

WORKDIR /opt

ENV MVN_VERSION 3.6.3
ENV GRAAL_VERSION 20.1.0
ENV M2_HOME /opt/maven
ENV GRAALVM_HOME /opt/graalvm-ce-java11-20.1.0
ENV PATH ${GRAALVM_HOME}/bin:${M2_HOME}/bin:${PATH}

RUN wget -nv https://apache.mirrors.nublue.co.uk/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz
RUN tar zxvf apache-maven-${MVN_VERSION}-bin.tar.gz
RUN ln -s apache-maven-${MVN_VERSION} maven

RUN wget -nv https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-java11-linux-amd64-${GRAAL_VERSION}.tar.gz
RUN tar zxvf graalvm-ce-java11-linux-amd64-${GRAAL_VERSION}.tar.gz

RUN update-alternatives --install /usr/bin/java java ${GRAALVM_HOME}/bin/java  3
RUN java --version

RUN gu install native-image
