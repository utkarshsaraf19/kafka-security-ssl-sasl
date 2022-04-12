FROM confluentinc/cp-kafka-connect-base:latest
COPY ./kafka-connect-script/connect-file-sink.properties /etc/kafka/
COPY ./kafka-connect-script/connect-file-source.properties /etc/kafka/
#COPY ./kafka-connect-script/docker-utils.jar /etc/confluent/docker/
COPY ./kafka-connect-script/kafka-env-config-provider-0.0.1.jar /usr/share/java/cp-base-new/
CMD ["/etc/confluent/docker/run"]
HEALTHCHECK --start-period=120s --interval=5s --timeout=10s --retries=96 \
	CMD /etc/confluent/docker/healthcheck.sh
#ENTRYPOINT ["tail"]
#CMD ["-f","/dev/null"]
