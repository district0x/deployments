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

### <a name="basic"> Basic usage

<!-- ### <a name="basic"> Basic usage -->

<!-- Start the services in the QA environment: -->

<!-- ``` bash -->
<!-- cd qa -->
<!-- docker-compose -f docker-compose.yml \ -->
<!--                -f memefactory/docker-compose.yml up -d -->
<!-- ``` -->
<!-- ### <a name="base"> Base docker image -->

<!-- This image comes with all the common dependencies and serves as the base for all other builds: -->

<!-- ```bash -->
<!-- docker build -t district0x/base base/ -->
<!-- ``` -->

<!-- ### <a name="memefactory-qa"> -->

<!-- If you want to create a QA environment for [MemeFactory](https://github.com/district0x/memefactory): -->

<!-- ```bash -->
<!-- cd memefactory/qa -->
<!-- docker-compose up -->
<!-- ``` -->

<!-- To update the ui to the master branch content: -->

<!-- ```bash -->
<!-- docker exec -it qa_ipfs update-ui -->
<!-- ``` -->
