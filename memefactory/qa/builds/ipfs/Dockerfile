FROM jbenet/go-ipfs:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# TODO UI update script
#ADD update.sh /usr/bin/update.sh
#RUN chmod a+x /usr/bin/update.sh

ARG IPFS_PRV_KEY

# Check for mandatory build arguments
RUN test -n "$IPFS_PRV_KEY"

WORKDIR data/ipfs/keystore/
RUN echo "$IPFS_PRV_KEY" > memefactory-qa