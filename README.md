# district-pipelines

This project contains docker and docker compose files for deploying qa and production environments of different districts.

## Installation

You need [Docker](https://www.docker.com/) installed.

```bash
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo apt-key add -

export LSB_ETC_LSB_RELEASE=/etc/upstream-release/lsb-release

V=$(lsb_release -cs)

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${V} stable"

sudo apt-get update -y

sudo apt-get install -y docker-ce
```

Add your user to the docker group. Added user can run docker command without sudo command:
```bash
sudo gpasswd -a "${USER}" docker
```

Test the installation:
```bash
docker run hello-world
```

You also need docker-compose:
``` bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod a+x /usr/local/bin/docker-compose
```

## Usage

#### <a name="base"> Base docker image

This image comes with all the common dependencies and serves as the base for all other builds:

```bash
cd memefactory/qa
docker build -t district0x/base builds/base
```

#### <a name="memefactory-qa">

If you want to create a QA environment for [MemeFactory](https://github.com/district0x/memefactory):
Start by building the ipfs image, you need to pass the private key corresponding to the node peer id:

```bash
docker build -t qa_ipfs builds/ipfs --build-arg ipfs_prv_key="$(cat ~/.ipfs/keystore/memefactory-qa)"
```
**Warning:** It is important to keep the image public, due to the stored secret!

```bash
cd memefactory/qa
docker-compose up
```
