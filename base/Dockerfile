FROM ubuntu:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# ENV variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.4.0
ENV LEIN_ROOT=1

# install system-wide deps
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
    -q wget curl ca-certificates software-properties-common unzip debconf rlwrap python build-essential git nano fish mlocate

# install Java
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get -y install oracle-java8-installer oracle-java8-set-default

# install solc
RUN add-apt-repository --yes ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install --yes git solc

# install lein
RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /bin/lein
RUN chmod a+x /bin/lein

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to PATH
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# seems to fix the checksum problem
# see https://stackoverflow.com/questions/47545940/npm-err-code-eintegrity-npm-5-3-0
RUN npm config set package-lock false

# run some checks
RUN java -version
RUN solc --version
RUN lein --version
RUN node --version
RUN npm --version
