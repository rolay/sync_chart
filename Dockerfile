FROM gcr.io/bitnami-labs/charts-syncer:v0.20.3 as build

FROM python:slim

ARG CHART_REPO
ARG CHART_USERNAME
ARG CHART_PASSWORD
ARG CONTAINER_REGISTRY
ARG CONTAINER_REPO

WORKDIR /
COPY .  /
COPY --from=build /charts-syncer /charts-syncer
RUN pip install -r requirements.txt && \
    python generate_sync_yaml.py
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
