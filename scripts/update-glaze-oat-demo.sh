#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

mkdir -p docs/glaze_oat

(
  cd glaze_oat
  gleam deps download
  gleam run -m glaze_oat_dev
)

echo "Updated docs/glaze_oat/index.html"
