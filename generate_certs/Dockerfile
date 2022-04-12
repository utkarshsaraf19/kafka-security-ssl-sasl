FROM fabric8/java-alpine-openjdk8-jdk

# Install OpenSSL
RUN apk update && \
  apk add --no-cache openssl bash && \
  rm -rf "/var/cache/apk/*"

# Create and set mount volume
WORKDIR /openssl-certs
VOLUME  /openssl-certs

COPY create-certs.sh create-certs.sh
RUN chmod +x /openssl-certs/create-certs.sh

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]