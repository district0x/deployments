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
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod a+x /usr/local/bin/docker-compose
```

## Usage

- [QA enviroment](#qa)
  - [parity](#parity)
    - [ropsten](#parity-ropsten)
  - [ipfs](#ipfs)
    - [daemon](#ipfs-daemon)
    - [api](#ipfs-api)
    - [gateway](#)
  - [memefactory](#memfactory)
    - [server](#memfactory-server)
    - [api](#memefactory-api)
    - [ui](#memefactory-ui)
- [base](#base)

### <a name="qa"> QA enviroment </a>

Start the services in the QA environment:

``` bash
cd qa/
docker-compose -f docker-compose.yml \
               -f memefactory/docker-compose.yml up -d
```

#### <a name="parity"> parity services </a>
##### <a name="ropsten"> ropsten service </a>

#### <a name="ipfs"> ipfs services </a>
##### <a name="ipfs-daemon"> ipfs daemon service </a>

<!-- needs private key -->

<!-- ```bash -->
<!-- docker exec -it qa_ipfs update-ui -->
<!-- ``` -->

##### <a name="ipfs-api"> ipfs api service </a>
##### <a name="ipfs-gateway"> ipfs gateway service </a>

#### <a name="memefactory"> memefactory services </a>
##### <a name="memfactory-server"> memefactory server service </a>
##### <a name="memefactory api"> memfactory api service </a>
##### <a name="memfactory ui"> memefactory ui service </a>

### <a name="base"> base image </a>

