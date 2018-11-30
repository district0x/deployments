FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# ENV variables
ENV CONFIG /config/meme.config.qa.edn

ADD meme.config.qa.edn /config/meme.config.qa.edn

# get server source code
RUN wget --no-check-certificate -O master.zip https://github.com/district0x/memefactory/archive/master.zip \
    && unzip master.zip \
    && mv memefactory-master memefactory

# add smart_contracts.cljs with ropsten addresses
RUN wget --no-check-certificate -O /memefactory/src/memefactory/shared/smart_contracts.cljs https://raw.githubusercontent.com/district0x/deployments/master/qa/memefactory/shared/smart_contracts.cljs

RUN cat /memefactory/src/memefactory/shared/smart_contracts.cljs

WORKDIR memefactory

RUN npm config set package-lock false

# build server
RUN lein deps
RUN lein solc once
RUN lein cljsbuild once "server"

EXPOSE 6300
CMD ["node", "server/memefactory.js"]
