FROM gcr.io/bitnami-labs/charts-syncer as build

FROM ubuntu:20.04
WORKDIR /
COPY --from=build /charts-syncer /charts-syncer
COPY .  /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]