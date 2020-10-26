#!/bin/bash

set -euxo pipefail

CHARTS="$@"
if [ -z "$CHARTS" ]; then
  CHARTS="--all"
else
  CHARTS="--charts $CHARTS"
fi

docker run --rm \
           --volume "$(pwd):/workdir" \
           --workdir /workdir \
           "quay.io/helmpack/chart-testing:v3.1.1" ct lint --config test/config.yaml --lint-conf test/lintconf.yaml $CHARTS
