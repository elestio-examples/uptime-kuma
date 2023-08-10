#!/usr/bin/env bash
npm run setup
docker buildx build . --output type=docker,name=elestio4test/uptime-kuma:latest | docker load