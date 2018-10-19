FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# install ipfs
RUN wget --no-check-certificate https://dist.ipfs.io/go-ipfs/v0.4.17/go-ipfs_v0.4.17_linux-amd64.tar.gz
RUN tar xvfz go-ipfs_v0.4.17_linux-amd64.tar.gz
WORKDIR go-ipfs
RUN bash install.sh
RUN ipfs init

WORKDIR /

# add update script
ADD update-ui.sh /usr/bin/update-ui
RUN chmod a+x /usr/bin/update-ui

EXPOSE 8080
EXPOSE 4001
EXPOSE 5001

CMD ["ipfs", "daemon"]