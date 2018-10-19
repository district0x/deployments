FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# ENV variables
ENV IPFS_LOGGING ""
ENV IPFS_VERSION v0.4.17
ENV TINI_VERSION v0.16.1

# install tini a minimal init daemon for containers
# RUN set -x \
#   && cd /tmp \
#   && wget -q -O tini https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini \
#   && chmod +x tini

# install ipfs
RUN wget --no-check-certificate https://dist.ipfs.io/go-ipfs/v0.4.17/go-ipfs_v0.4.17_linux-amd64.tar.gz
RUN tar xvfz go-ipfs_v0.4.17_linux-amd64.tar.gz
WORKDIR go-ipfs
RUN bash install.sh

# RUN ipfs init
# RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
# RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["GET", "POST", "PUT"]'
# RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization"]'
# RUN ipfs config --json API.HTTPHeaders.Access-Control-Expose-Headers '["Location"]'
# RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'

RUN ipfs init
RUN ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
RUN ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
RUN ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'

WORKDIR /

# add update script
ADD update-ui.sh /usr/bin/update-ui
RUN chmod a+x /usr/bin/update-ui

# Ports for Swarm TCP, Swarm uTP, API, Gateway, Swarm Websockets
EXPOSE 4001
EXPOSE 4002/udp
EXPOSE 5001
EXPOSE 8080
EXPOSE 8081

# This just makes sure that:
# 1. There's an fs-repo, and initializes one if there isn't.
# 2. The API and Gateway are accessible from outside the container.
#ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/ipfs"]

# Execute the daemon subcommand by default
#CMD ["daemon", "--migrate=true"]

CMD ["ipfs", "daemon"]