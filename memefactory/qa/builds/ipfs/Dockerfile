FROM jbenet/go-ipfs:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

ARG IPFS_PRV_KEY

# Check for mandatory build arguments
RUN test -n "$IPFS_PRV_KEY"

WORKDIR data/ipfs/keystore/
RUN echo "$IPFS_PRV_KEY" > memefactory-qa