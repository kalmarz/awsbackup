FROM debian:stable-slim

RUN apt update && \
    apt install -y \
      curl \
      jq \
      sqlite3 \
      unzip \
      zip && \
    apt autoremove -y && \
    apt clean && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
      unzip awscliv2.zip && \
      ./aws/install && \
      rm awscliv2.zip && \
      rm -rf ./aws

WORKDIR /app
COPY sqlite_backup2s3.sh ${WORKDIR}