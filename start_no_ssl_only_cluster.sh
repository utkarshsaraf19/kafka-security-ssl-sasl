#!/usr/bin/env bash

export KAFKA_SSL_SECRETS_DIR=$PWD/secrets
cd $PWD/ssl-only/
docker-compose -f single-node-docker-compose.yml up --build -d
