#!/bin/bash

echo 116.205.232.249 chart.paas.talkweb.com.cn >> /etc/hosts

for file in $(ls chart-*.yaml); do
    echo "[chart sync] $file sync start"
    /charts-syncer sync --config $file -v 4 --latest-version-only
    echo "[chart sync] $file sync done"
    sleep 2
done
