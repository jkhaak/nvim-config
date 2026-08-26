#!/usr/bin/env bash

set -euo pipefail

nvim --headless --listen 0.0.0.0:1234 &
NVIM_PID@=$!

# Give nvim a moment to start
sleep 1
if ! kill -0 $NVIM_PID 2>/dev/null; then
    echo "ERROR: Neovim failed to start" >&2
    return 1
fi

echo "Neovim listening on 0.0.0.0:1234 (pid: $NVIM_PID)" >&2

