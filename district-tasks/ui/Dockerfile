FROM district0x/base
RUN wget --no-check-certificate -O master.zip https://github.com/district0x/district0x-tasks/archive/master.zip \
    && unzip master.zip \
    && mv district0x-tasks /app
WORKDIR /app
COPY . .
RUN lein deps
RUN lein solc once
RUN lein cljsbuild once "ui"
EXPOSE 80
RUN apt-get --allow-releaseinfo-change update
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y -q nginx
CMD ["nginx", "-g", "daemon off"]

HEALTHCHECK --interval=5m --timeout=3s --retries=3 \
    CMD curl --output /dev/null --silent --head --fail -k http://localhost:80 || exit 1