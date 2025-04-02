#!/usr/bin/env bash

set -veuo pipefail

echo '---------- set up Night Shift ----------'
if which nightlight; then
  nightlight on
  nightlight temp 100
  nightlight schedule 6:00 5:59
else
  echo 'missing nightlight command'
fi
