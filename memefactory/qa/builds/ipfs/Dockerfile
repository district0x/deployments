FROM jbenet/go-ipfs:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

ARG IPFS_PRV_KEY

RUN \
# Check for mandatory build arguments
    : "${MANDATORY_BUILD_ARGUMENT:?Build argument needs to be set and non-empty.}" \

WORKDIR data/ipfs/keystore/
RUN echo "$IPFS_PRV_KEY" > memefactory-qa