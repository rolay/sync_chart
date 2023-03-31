FROM gcr.io/bitnami-labs/charts-syncer

COPY chart-*.yaml  /
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]