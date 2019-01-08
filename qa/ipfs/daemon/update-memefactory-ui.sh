#!/bin/bash

# get source code
wget --no-check-certificate -O master.zip https://github.com/district0x/memefactory/archive/master.zip \
     && unzip master.zip \
     && mv memefactory-master memefactory

# add smart_contracts.cljs with ropsten addresses
wget --no-check-certificate -O /memefactory/src/memefactory/shared/smart_contracts.cljs \
https://raw.githubusercontent.com/district0x/deployments/master/qa/memefactory/shared/smart_contracts.cljs

cd memefactory/

# build ui
lein deps
lein garden once
lein solc once
MEMEFACTORY_ENV=qa lein cljsbuild once "ui"

# publish new UI content
HASH=$(ipfs add -r resources/public/ |  tail -1 | grep -o -P '(?<=added).*(?=public)')

echo "IPFS hash: $HASH"

ipfs name publish --lifetime "99999h" --ttl "99999h" --key=memefactory-qa $HASH

# clean up
cd ../
rm -rf master.zip memefactory/

echo "Done"
exit $?
