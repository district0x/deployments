# Memefactory
- [QA and Production](#qa-and-production)
  - [Boxes connection info](#boxes)
  - [Configuration files](#configuration-files)
  - [Components (docker services)](#components)
  - [Troubleshooting](#troubleshooting)
  - [Deployment instructions](#deployment)
  - [Rollback instructions](#rollback)
- [Dev](#dev)

## <a name="qa-and-production"></a> QA and Production

### <a name="boxes"></a> Boxes connection info

```bash
ssh ubuntu@district0x.io    # (production box)
ssh ubuntu@qa.district0x.io # (qa box)
```

### <a name="configuration-files"></a> Configuration files

```bash
/home/ubuntu/configs/blacklist.qa.edn (QA)
/home/ubuntu/configs/meme.config.qa.edn (QA)
```

```bash
/home/ubuntu/configs/blacklist.prod.edn (PRODUCTION)
/home/ubuntu/configs/meme.config.prod.edn (PRODUCTION)
```

### <a name="components"></a> Components (docker services)

#### memefactory-ui
This contains everything needed to serve memefactory ui under `/wwwroor`

#### memefactory-server
This contains everything needed to run a memefactory server `node_modules`, `resources` and `server`, being server the compilaton
output of the clojurescript compiler for the server build.

#### ipfs-server (shared with other districts)
This exposes the ipfs node api and gateway

#### ipfs-daemon (shared with other districts)
This service provides the ipfs daemon. No ports are exposed to the host, and the containers that wish to have access to ipfs should join the ipfs-net network.

#### nginx (shared with other districts)
This contains a nginx instance for serving districts UI files while also acts as a ipfs gateways proxy.

#### rinkeby,ropsten (shared with other districts)
This services provide parity ethereum nodes.

#### letsencrypt-nginx-proxy-companion (shared with other districts)
It handles the automated creation, renewal and use of Let's Encrypt certificates for proxyed Docker containers.

#### watchtower (shared with other districts)
This service checks for latest images and quietly updates running containers. Services subscribing do so by declaring a LABEL com.centurylinklabs.watchtower.enable="true".

### <a name="troubleshooting"></a> Troubleshooting

#### Components

Use `docker ps` to check the status of containers

Use `docker-compose -f /home/ubuntu/deployments/qa/docker-compose.yml ps --services` to list all services

For each service we can take a look at its log by

`docker-compose -f /home/ubuntu/deployments/qa/docker-compose.yml logs --tail=100  memefactory-server` adding more services at the end will combine the logs

To restart a service, lets say memefactory-server

`docker-compose -f docker-compose.yml restart memefactory-server`

### <a name="deployment"></a> Deployment instructions

For deploying new memefactory code the github production branch needs to be pointed to the new commit.

In normal situations this is accomplished by running on your local box

```bash
git checkout master && git pull origin master # make sure you have a updated master
git checkout production && git pull origin producton # make sure you have a updated production
git merge --ff-only master # fast forward production to master
```
From here on, travis will build new docker images from the production branch and publish them. Watchtower
system will see new versions of images and install them.

#### Considerations (IMPORTANT)

Check :
- New deployment doesn't need schema changes
- All migrations had been run

If the new deployment needs db schema changes run

```bash
docker-compose -f docker-compose.yml stop memefactory-server
mv /home/ubuntu/db/memefactory.db /home/ubuntu/db/memefactory-$(date +%d-%m-%y).db.bkp
```
before the new deployment runs (REVIEW THIS PLEASE)

### <a name="rollback"></a> Rollback instructions

#### Method 1, the full rollback (preferred)

```
git checkout production && git pull origin master
git log # spot the COMIT-HASH we want to revert to
git reset --hard COMIT-HASH
git push -f origin production (WE NEED TO ENABLE FORCED PUSHES ON PROD)
```

From here on the same considerations as in Deployments apply

#### Method 2, docker images roll back

Search images in docker hub :
https://hub.docker.com/r/district0x/memefactory-ui/tags (For memefactory UI)
https://hub.docker.com/r/district0x/memefactory-server/tags (For memefactory Server)

Lets say we want to roll back only memefactory server in production
1 - Grab the version corresponding to the commit you want to roll back to, lets say 484fda7
2 - Edit `/home/ubuntu/deployments/prod/docker-compose.yml`
3 - Under memefactory-server replace the image field from district0x/memefactory-server:latest to district0x/memefactory-server:484fda7
4 - Run `docker-compose -f /home/ubuntu/deployments/prod/docker-compose.yml up -d --build`

From here on the same considerations as in Deployments apply

### Nginx important files

All files under :

/home/ubuntu/nginx-docker/vhost.d/
/home/ubuntu/nginx-docker/conf.d/

## <a name="dev"></a> Dev

TBD
