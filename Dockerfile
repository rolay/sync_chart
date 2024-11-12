FROM bitnami/charts-syncer:2 as build

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
