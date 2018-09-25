#FROM java:8
FROM ubuntu:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# ENV variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.4.0
ENV LEIN_ROOT=1

# install system-wide deps
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
    -q wget curl ca-certificates software-properties-common unzip debconf rlwrap python build-essential git

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

# confirm installation
RUN node -v
RUN npm -v
RUN lein -v

# get server source code
RUN wget --no-check-certificate -O master.zip https://github.com/district0x/memefactory/archive/master.zip \
    && unzip master.zip \
    && mv memefactory-master memefactory

WORKDIR memefactory

# build server
RUN npm config set package-lock false
#RUN lein deps
RUN lein npm install
RUN lein solc once
RUN lein cljsbuild once "server"

EXPOSE 6300
CMD ["node", "server/memefactory.js"]
