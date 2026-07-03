#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"
git submodule update --init --recursive -- lib/libaribb25

cd lib/libaribb25
cmake .
make
make install
echo "done!"
