#!/usr/bin/env bash
#
# Cross-compiles the DSP for the Move (ARM64) in Docker and packages dist/.
#
# The tarball's top-level directory MUST be the module id: the host extracts it
# straight into modules/<component_type>s/, so a mismatched name installs a
# module nobody can find.
set -euo pipefail
cd "$(dirname "$0")/.."

ID=velocity_scale
IMAGE=schwung-velocity-scale-builder

docker build -q -t "$IMAGE" -f scripts/Dockerfile scripts/ >/dev/null
echo "==> compiling with aarch64-linux-gnu-gcc"
docker run --rm -v "$PWD":/build -w /build "$IMAGE" \
    aarch64-linux-gnu-gcc -g -O3 -shared -fPIC \
        src/dsp/velocity_scale.c \
        -o /build/dsp.so \
        -Isrc/host -lm

echo "==> packaging dist/"
rm -rf dist && mkdir -p "dist/$ID"
mv dsp.so "dist/$ID/dsp.so"
cp src/module.json "dist/$ID/"
[ -f src/help.json ] && cp src/help.json "dist/$ID/"
( cd dist && tar -czf "$ID-module.tar.gz" "$ID/" )
echo "==> done: dist/$ID-module.tar.gz"
