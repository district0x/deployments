FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# ENV variables
ENV CONFIG /config/meme.config.qa.edn

ADD meme.config.qa.edn /config/meme.config.qa.edn

# get server source code
RUN wget --no-check-certificate -O master.zip https://github.com/district0x/memefactory/archive/master.zip \
    && unzip master.zip \
    && mv memefactory-master memefactory

WORKDIR memefactory

# build server
RUN lein deps
RUN lein solc once
RUN lein cljsbuild once "dev-server"

EXPOSE 6300
CMD ["node", "dev-server/memefactory.js"]
