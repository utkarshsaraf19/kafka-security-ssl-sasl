#!/usr/bin/env bash
# start single cluster

sudo su 
docker ps -aq | xargs docker stop | xargs docker rm

sudo docker-compose -f single-node-docker-compose.yml up --build -d

export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/kafka-security-ssl-sasl/secrets
sudo ./start_ssl_only_cluster.sh

export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-topics --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --create --topic Devtest --partitions 10 --replication-factor 1 --command-config /etc/kafka/secrets/host.producer.ssl.config
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-topics --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --create --topic UItest --partitions 10 --replication-factor 1 --command-config /etc/kafka/secrets/host.producer.ssl.config


sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-acls --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --command-config /etc/kafka/secrets/host.producer.ssl.config --add --allow-host '*' --allow-principal User:CN=kafka-producer,OU=Dev,O=HusseinJoe,L=Melbourne,ST=VIC,C=AU --operation write --topic Dev --resource-pattern-type prefixed
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-acls --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --command-config /etc/kafka/secrets/host.producer.ssl.config --add --allow-host '*' --allow-principal User:CN=kafka-producer,OU=Dev,O=HusseinJoe,L=Melbourne,ST=VIC,C=AU --operation write --topic UI --resource-pattern-type prefixed

sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-acls --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --command-config /etc/kafka/secrets/host.producer.ssl.config --add --allow-host '*' --allow-principal User:CN=kafka-consumer,OU=Dev,O=HusseinJoe,L=Melbourne,ST=VIC,C=AU --operation read --topic Dev --resource-pattern-type prefixed
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-acls --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --command-config /etc/kafka/secrets/host.producer.ssl.config --add --allow-host '*' --deny-principal User:CN=kafka-consumer,OU=Dev,O=HusseinJoe,L=Melbourne,ST=VIC,C=AU --operation read --topic UI --resource-pattern-type prefixed


export KAFKA_SSL_SECRETS_DIR=$PWD/secrets
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-acls --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --command-config /etc/kafka/secrets/host.producer.ssl.config --list


winpty docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-avro-console-consumer \
    --bootstrap-server kafka-broker-1:19093 \
    --topic mqtt \
    --from-beginning
Clean up 


export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run --name producer-dev -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-producer --broker-list kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --topic Devtest --producer.config /etc/kafka/secrets/host.producer.ssl.config

export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run --name producer-UI -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-producer --broker-list kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --topic UItest --producer.config /etc/kafka/secrets/host.producer.ssl.config


export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run --name consumer-dev -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/consumer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-consumer --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --topic Devtest --from-beginning --consumer.config /etc/kafka/secrets/host.consumer.ssl.config

export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run --name consumer-test -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/consumer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-consumer kafka-console-consumer --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --topic UItest --from-beginning --consumer.config /etc/kafka/secrets/host.consumer.ssl.config


export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-topics --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --create --topic DevAnotherTest --partitions 10 --replication-factor 1 --command-config /etc/kafka/secrets/host.producer.ssl.config


export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run --name producer-dev-another -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-producer --broker-list kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --topic DevAnotherTest --producer.config /etc/kafka/secrets/host.producer.ssl.config

export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run --name consumer-dev-another -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/consumer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-consumer --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --topic DevAnotherTest --from-beginning --consumer.config /etc/kafka/secrets/host.consumer.ssl.config



export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run  --name adminUI -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-topics --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --create --topic UIAnotherTest --partitions 10 --replication-factor 1 --command-config /etc/kafka/secrets/host.producer.ssl.config


export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run --name producer-UI-another -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-producer --broker-list kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --topic UIAnotherTest --producer.config /etc/kafka/secrets/host.producer.ssl.config

export KAFKA_SSL_SECRETS_DIR=/home/q/Desktop/certificates/kafka-security-ssl-sasl/secrets
sudo docker run --name consumer-UI-another -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/consumer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-consumer --bootstrap-server kafka-broker-1:19093,kafka-broker-2:29093,kafka-broker-3:39093 --topic UIAnotherTest --from-beginning --consumer.config /etc/kafka/secrets/host.consumer.ssl.config



# KAFKA Connect
winpty docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-topics --bootstrap-server kafka-broker-1:19093 --create --topic mqtt --partitions 10 --replication-factor 1 --command-config /etc/kafka/secrets/host.producer.ssl.config
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-topics --bootstrap-server kafka-broker-1:19093 --create --topic quickstart-config --partitions 10 --replication-factor 1 --command-config /etc/kafka/secrets/host.producer.ssl.config
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-topics --bootstrap-server kafka-broker-1:19093 --create --topic quickstart-offsets --partitions 10 --replication-factor 1 --command-config /etc/kafka/secrets/host.producer.ssl.config
sudo docker run  --name admin -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/producer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-topics --bootstrap-server kafka-broker-1:19093 --create --topic quickstart-status --partitions 10 --replication-factor 1 --command-config /etc/kafka/secrets/host.producer.ssl.config

sudo docker run --name consumer-dev -it --rm -v ${KAFKA_SSL_SECRETS_DIR}/consumer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-consumer --bootstrap-server kafka-broker-1:19093 --topic test --from-beginning --consumer.config /etc/kafka/secrets/host.consumer.ssl.config

winpty docker run --name consumer-dev -it --rm -v /d/kafka/kafka-security-ssl-sasl/secrets/consumer:/etc/kafka/secrets --network kafka-cluster-network confluentinc/cp-kafka:latest kafka-console-consumer --bootstrap-server kafka-broker-1:19093 --topic mqtt --from-beginning --consumer.config /etc/kafka/secrets/host.consumer.ssl.config