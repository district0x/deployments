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
- [DEV](#dev)
  - [ganache](#dev_ganache)
  - [ipfs-daemon](#dev_ipfs-daemon)
  - [memefactory](#dev_memefactory)
     - [memefactory-ui](#dev_memefactory-ui)
- [QA](#qa)
  - [rinkeby](#rinkeby_geth)
  - [ropsten](#ropsten_parity)
  - [ipfs daemon](#qa_ipfs-daemon)
  - [ipfs server](#qa_ipfs-server)
  - [nginx](#qa_nginx)
  - [letsencrypt](#qa_letsencrypt)
  - [watchtower](#qa_watchtower)
  - [memefatory_server](#qa_memfactory-server)
  - [memefatory_ui](#qa_memfactory-ui)
  - [registry-server](#qa_registry-server)
  - [registry-ui](#qa_registry-ui)
- [PROD](#prod)
  - [parity](#mainnet_parity)
  - [ipfs daemon](#prod_ipfs-daemon)
  - [ipfs server](#prod_ipfs-server)
  - [nginx](#prod_nginx)
  - [letsencrypt](#prod_letsencrypt)
  - [watchtower](#prod_watchtower)
  - [district0x-contribution-page](#district0x-contribution-page)
  - [district0x-voting-page](#district0x-voting-page)
  - [district0x-landing-page](#district0x-landing-page)
  - [namebazaar-ui](#prod_namebazaar-ui)
  - [ethlance](#prod_ethlance)
    - [ethlance-ui](#prod_ethlance-ui)
    - [ethlance-emailer](#prod_ethlance-emailer)
  - [memefactory](#prod_memefactory)
     - [memefatory server](#prod_memfactory-server)
     - [memefatory ui](#prod_memefactory-ui)

# <a name="dev"> development enviroment services </a>

Base images for district0x development.
Contains all services needed for running and building districts locally.
Consult the docker-compose file for details of what's availiable.

Start just the base services:

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

## <a name="dev_ganache"> ganache </a>

This service provides the personal Ethereum blockchain.
By default it exposes the API on port `8549`.
To connect your [web3 instance](https://github.com/district0x/district-server-web3) put this in your [config](https://github.com/district0x/district-server-config):

```edn
:web3 {:url "http://localhost:8549"}
```

## <a name="dev_ipfs-daemon"> ipfs daemon </a>

This service provides the ipfs network daemon.
The api is exposed on local port `5001` and gateway on `8080`.

To connect your [ipfs instance](https://github.com/district0x/district-server-ipfs) put this in your [config](https://github.com/district0x/district-server-config):

```edn
:ipfs {:endpoint "/api/v0"
       :host "http://localhost:5001"
       :gateway "http://localhost:8080/ipfs"}
```

## <a name="dev_memefactory"> memefactory services </a>

This container config provides services for the development of [memefactory](https://github.com/district0x/memefactory/) district.

### <a name="dev_memefactory-ui"> memefactory-ui  </a>

This container will serve static content compiled by figwheel on port `3001`, allowing you to test and devlop things like pushroutes or prerendering.
You need to set an environment variable pointint to the root directory of the project before using it:

```
export MEMEFACTORY_DIR=</path/to/memefactory>
```

# <a name="qa"> QA enviroment services </a>

Start the services in the QA environment:

``` bash
cd qa/
docker-compose -f docker-compose.yml up -d --build
```

## <a name="rinkeby_geth"> rinkeby </a>

This service provides a geth node of the `rinkeby` testnet.
It doesn't forward any ports to the host, but the [nginx](#qa_nginx) proxy exposes its http API as a `rinkeby.district0x.io` virtual host.

See [mainnet](#prod_mainet) for setials on how to tets the connection.

## <a name="ropsten_parity"> ropsten </a>

This service provides a geth node of the `ropsten` testnet.
It's exposed as a `ropsten.district0x.io` virtual host

## <a name="qa_ipfs-daemon"> ipfs daemon </a>

[ipfs](ipfs.io) network daemon service.
See [ipfs daemon](#prod_ipfs-daemon) for details.

## <a name="qa_ipfs-server"> ipfs server </a>

Proxy companion to the the ipfs daemon service.

Epxosed as `ipfs.qa.district0x.io` virtual host.

To connect your [ipfs instance](https://github.com/district0x/district-server-ipfs) specify these connection details in your [config](https://github.com/district0x/district-server-config):

```edn
:ipfs {:endpoint "/api/v0"
       :host "https://ipfs.qa.district0x.io/api"
       :gateway "https://ipfs.qa.district0x.io/gateway/ipfs"}
```

See [ipfs server](#prod_ipfs-server) for details.

## <a name="qa_nginx"> nginx </a>

Automated nginx reverse proxy service.
See [nignx](#prod_nginx) for details.

## <a name="qa_letsencrypt"> letsencrypt </a>

Automated SSL ceritficate service.
See [letsencrypt](#prod_letsencrypt) for details.

## <a name="qa_watchtower"> watchtower </a>

Service for automatically updating running containers.
See [watchtower](#prod_watchtower) for details.

## <a name="qa_memefactory-server"> memefactory-server </a>

Memefactory backend container service.
See [memefactory-server](#prod_memefactory-server) for details.

## <a name="qa_memefactory-ui"> memefactory-ui </a>

Webserver for serving static memefactory UI content.
See [memefactory-ui](#prod_memefactory-ui) for details.

## <a name="qa_registry-server"> registry-server </a>

TODO

## <a name="qa_registry-ui"> registry-ui </a>

TODO

# <a name="prod"> production environment services </a>

Start all the production services:

```bash
cd prod/
docker-compose -f docker-compose.yml up -d --build
```

## <a name="mainnet_parity"> mainnet </a>

This service provides a parity instance of the ethereum `mainnet`.
It doesn't forward any ports to the host, but the [nginx](#prod_nginx) proxy exposes its http API as a virtual host on the standard SSL port.

You can test the connection locally:

```bash
curl --data '{"method":"eth_blockNumber","params":[],"id":1,"jsonrpc":"2.0"}' -H "Host: mainnet.district0x.io" -H "Content-Type: application/json" -X POST https://localhost:443 -k
```
or from the outside using the DNS's (managed with [route 53](https://console.aws.amazon.com/route53)):

```bash
curl --data '{"method":"eth_blockNumber","params":[],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST https://mainnet.district0x.io
```

## <a name="prod_ipfs-daemon"> ipfs daemon </a>

This service provides the [ipfs](ipfs.io) network daemon.
It provides access to the both the http API and a read-only gateway, but doesn't expose them to the host network.
This is done by the accompanying [ipfs server](#prod_ipfs-server).

Docker image repository and documentation: [district0x/ipfs-docker](https://github.com/district0x/ipfs-docker).

## <a name="prod_ipfs-server"> ipfs server </a>

This service is an nginx proxy companion to the [ipfs daemon](#prod_ipfs-daemon) service.
It maps daemon ports to endpoints allowing the use of a single virtual host for all things ipfs:

* the ipfs http API is accesible on the `/api` endpoint
* the read-only gateway is accessible as `/gateway` endpoint

Docker image repository and documentation: [district0x/ipfs-docker](https://github.com/district0x/ipfs-docker).

This service doesn't forward any ports to the host, rather the [nginx](#prod_nginx) proxy exposes it as a `ipfs.district0x.io` virtual host.
You can test the gateway endpoint connection like this:

```bash
curl https://ipfs.district0x.io/gateway/ipfs/QmTeW79w7QQ6Npa3b1d5tANreCDxF2iDaAPsDvW6KtLmfB/
```

Test the http API endpoint connection:

```bash
curl https://ipfs.qa.district0x.io/api/api/v0/version
```

To connect your [ipfs instance](https://github.com/district0x/district-server-ipfs) put this in your [config](https://github.com/district0x/district-server-config):

```edn
:ipfs {:endpoint "/api/v0"
       :host "https://ipfs.district0x.io/api"
       :gateway "https://ipfs.district0x.io/gateway/ipfs"}
```
## <a name="prod_nginx"> nginx </a>

This service provides an automated nginx reverse proxies to other docker containers running in this envirnment.

---
**NOTE**
As a general rule all the other containers are not directly exposed to the host, rather this service routes the traffic to them based on the `VIRTUAL_HOST` environment variable passed to the container config.
Host specific configs are mounted in the `home/$USER/nginx-docker/vhost.d` directory on the hosts filesystem.

---

For documentation and details: https://github.com/jwilder/nginx-proxy

## <a name="prod_letsencrypt"> letsencrypt </a>

This is a companion service to the [nginx proxy](#prod_nginx).
It automates the handling, creation and renewal of [Let's Encrypt](https://letsencrypt.org/) SSL certificates.

For documentation and details: https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion

## <a name="prod_watchtower"> watchtower </a>

This service is responsible for automatically updating running containers.
Containers opt-in by using a `com.centurylinklabs.watchtower.enable` docker label.

Watchtower will periodicaly check Docker Hub for any newer versions of the image with a given tag.
You update containerized districts simply by pushing a new image to the docker repository.

---
**NOTE**

By convention images built on a `master` (QA) branch are tagged as `latest`, and on the production branch as `release`.

---

For documentation and details: https://github.com/containrrr/watchtower

## <a name="district0x-contribution-page"> district0x-contribution-page </a>

This service serves static content and is accessible under `contribution.district0x.io` virtual host.

## <a name="district0x-voting-page"> district0x-voting-page </a>

This service serves static content and is accessible under `vote.district0x.io` virtual host.

## <a name="district0x-landing-page"> district0x-landing-page </a>

This service serves static content and is accessible under `district0x.io` virtual host.
Unlike other production services for convenience of the ops-team it is built on the `master` branch of the [repository](https://github.com/district0x/district0x-landing-page)

## <a name="prod_namebazaar-ui"> namebazaar-ui </a>

This service serves static content and is accessible under `namebazaar.io` virtual host.

## <a name="prod_ethlance"> ethlance services </a>

### <a name="prod_ethlance-ui"> ethlance-ui </a>

This service is a webserver serving the ethlance UI and is accessible under `ethlance.com` virtual host.

Repository: https://github.com/district0x/ethlance

### <a name="prod_ethlance-emailer"> ethlance-emailer </a>

This service is the backend infrastructure of [ethlance](ethlance.com).

Repository: https://github.com/district0x/ethlance-emailer

## <a name="prod_memefactory"> memefactory services </a>

### <a name="prod_memefactory-server"> memefactory-server </a>

This service is the backend infrastructure of [memefactory](memefactory.io).
It mainly provides graphql enpdoints over a cache of database built from the ethereum event logs.

It's exposed as `api.memefactory.district0x.io`.
The connectivity to graphql endpoints can be quickly checked by sending an event query:

```bash
curl -X POST -H "Content-Type: application/json" --data '{ "query": "{ events { event_contractKey event_eventName event_count event_lastLogIndex event_lastBlockNumber}}" }' https://api.memefactory.io/graphql
```

This container service shares volumes with the host:

* `db/` - for the [database](https://github.com/district0x/district-server-db) file.
* `logs/` - for the [server logs](https://github.com/district0x/district-server-logging). All server logs are shipped to [cloudwatch](https://us-west-2.console.aws.amazon.com/cloudwatch/home?region=us-west-2#dashboards) using a cloudwatch agent, all logging events as or more sever than `warning` are shipped to [sentry](https://sentry.io/organizations/district0x/issues/?environment=PRODUCTION&project=1306960) with a slack notifcations.
* `configs/` - for the [config](https://github.com/district0x/district-server-config)

Docker will keep trying to restart this service on failure.

Repository: https://github.com/district0x/memefactory

### <a name="prod_memefactory-ui"> memefactory-ui </a>

This service is a webserver serving the memefactory browser UI and is accessible as the `memefactory.io` virtual host.
It is built by extending the [prerender](https://github.com/sanfrancesco/prerendercloud-server) webserver image to provide server-side rendering for bots and web crawlers.

Repository: https://github.com/district0x/memefactory
