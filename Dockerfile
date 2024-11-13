FROM gcr.io/bitnami-labs/charts-syncer:v0.20.3 as build

FROM python:slim

ARG CHART_REPO
ARG USER
ARG PASS
WORKDIR /
COPY .  /
COPY --from=build /charts-syncer /charts-syncer
RUN pip install -r requirements.txt && \
    python generate_sync_yaml.py
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
