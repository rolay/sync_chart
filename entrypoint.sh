#!/bin/bash

for file in chart-*.yaml; do
    echo "[chart sync] $file sync start"
    /charts-syncer sync --config $file -v 4 --latest-version-only
    echo "[chart sync] $file sync done"
    sleep 2
done
