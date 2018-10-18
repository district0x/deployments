FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# build arguments
ARG IPFS_PRV_KEY

# Check for mandatory build arguments
RUN test -n "$IPFS_PRV_KEY"

# install ipfs
RUN wget --no-check-certificate https://dist.ipfs.io/go-ipfs/v0.4.17/go-ipfs_v0.4.17_linux-amd64.tar.gz
RUN tar xvfz go-ipfs_v0.4.17_linux-amd64.tar.gz
WORKDIR go-ipfs
RUN ./install.sh
RUN ipfs init

# add private key
WORKDIR data/ipfs/keystore/
RUN echo "$IPFS_PRV_KEY" > memefactory-qa

# add update script
WORKDIR /
ADD update-ui.sh /usr/bin/update-ui
RUN chmod a+x /usr/bin/update-ui

EXPOSE 8080
EXPOSE 4001
EXPOSE 5001

# run checks
RUN ipfs --version
RUN ipfs key list

CMD ["ipfs", "daemon"]










# FROM jbenet/go-ipfs:latest
# MAINTAINER "Filip Bielejec" <filip@district0x.io>

# # TODO UI update script
# #ADD update.sh /usr/bin/update.sh
# #RUN chmod a+x /usr/bin/update.sh

# ARG IPFS_PRV_KEY

# # Check for mandatory build arguments
# RUN test -n "$IPFS_PRV_KEY"

# WORKDIR data/ipfs/keystore/
# RUN echo "$IPFS_PRV_KEY" > memefactory-qa

