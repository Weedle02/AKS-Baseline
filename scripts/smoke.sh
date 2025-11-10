#!/usr/bin/env bash
set -euo pipefail
URL="https://{{PLACEHOLDER_DNS}}"
curl -fsSL "$URL/health" || exit 1
echo "Smoke OK"
