#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"
git submodule update --init --recursive -- lib/recdvb

cd lib/recdvb
./autogen.sh
./configure --enable-b25
make
make install
echo "done!"
