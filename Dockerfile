FROM gcr.io/bitnami-labs/charts-syncer as build

FROM ubuntu:20.04
COPY --from=build /charts-syncer /charts-syncer
COPY chart-*.yaml  /
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]