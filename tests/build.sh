#!/usr/bin/env bash
mv README.md elestio/tests/
npm run setup
rm -rf README.md
mv elestio/tests/README.md ./
docker buildx build . --output type=docker,name=elestio4test/uptime-kuma:latest | docker load
