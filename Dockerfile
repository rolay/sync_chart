FROM gcr.io/bitnami-labs/charts-syncer as build

FROM ubuntu:20.04

WORKDIR /
COPY .  /
COPY --from=build /charts-syncer /charts-syncer
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    python3 -m pip install --upgrade pip && \
    pip3 install -r requirements.txt && \
    python3 generate_sync_yaml.py
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]