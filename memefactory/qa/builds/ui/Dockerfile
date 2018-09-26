FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# get source code
RUN wget --no-check-certificate -O master.zip https://github.com/district0x/memefactory/archive/master.zip \
    && unzip master.zip \
    && mv memefactory-master memefactory

WORKDIR memefactory

# build ui
RUN npm config set package-lock false
RUN lein npm install
RUN lein cljsbuild once "dev-ui"

# TODO : upload to ipns
# TODO : nginx
