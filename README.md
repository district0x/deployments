# district-deployments

This project contains docker images and docker-compose scripts for deploying districts to different environments.

## Requirements

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
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod a+x /usr/local/bin/docker-compose
```

## Usage
- [QA](#qa)
  - [parity](#qa_parity)
  - [ipfs daemon](#qa_ipfs-daemon)
  - [ipfs server](#qa_ipfs-server)
  - [watchtower](#qa_watchtower)
- [PROD](#prod)
  - [memefatory server](#prod_memfactory-server)
  - [memefatory ui](#prod_memefactory-ui)
- [DEV](#dev)
  - [ganache](#dev_ganache)

## <a name="qa"> QA enviroment </a>

Start the services in the QA environment:

``` bash
cd qa/
docker-compose -f docker-compose.yml up -d --build
```

These containers define all the basic services needed in the QA environment:

### <a name="qa_parity"> parity </a>

### <a name="qa_ipfs-daemon"> ipfs daemon </a>

This service provides the ipfs daemon.
No ports are exposed to the host, and the containers that wish to have access to ipfs should join the `ipfs-net` network.

### <a name="qa_ipfs-server"> ipfs api and gateway </a>

### <a name="qa_watchtower"> watchtower </a>

This service checks for `latest` images and quietly updates running containers.
Services subscribing do so by declaring a LABEL `com.centurylinklabs.watchtower.enable="true"`.

### <a name="qa_memefactory-server"> memefactory server </a>

This service is the server component of MemeFactory, which serves as cache for Blockchain events, it also runs a graphql endpoint.
No ports are exposed to the host.

### <a name="qa_memefactory-ui"> memefactory ui </a>

This container serves the static content.

## <a name="prod"> PROD enviroment </a>

``` bash
cd prod/
docker-compose -f docker-compose.yml up -d --build
```

## <a name="dev"> DEV enviroment </a>

Base image for district0x development.
Contains all services needed for running and building districtc locally.
Consult the docker-compose file for details of what's availiable.

Start the base services:

``` bash
cd dev/
docker-compose -f docker-compose.yml up --build
```

If you want to start the memefactory services as well:

``` bash
cd dev/
export MEMEFACTORY_DIR=</path/to/memefactory>
docker-compose -f docker-compose.yml \
               -f memefactory/docker-compose.yml up --build
```

