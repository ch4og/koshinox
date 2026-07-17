#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE="$ROOT_DIR/nix/driver.template"
DRIVER_NIX="$ROOT_DIR/nix/driver.nix"

echo "Fetching driver version from Guix..."
VERSION=$(guix repl -L"$ROOT_DIR" /dev/stdin <<'EOF'
(use-modules (nongnu packages nvidia) (guix packages))
(display (package-version nvidia-driver-new-feature))
EOF
)
echo "Version: $VERSION"

URL="https://download.nvidia.com/XFree86/Linux-x86_64/${VERSION}/NVIDIA-Linux-x86_64-${VERSION}.run"
echo "Prefetching $URL..."
OUTPUT=$(nix store prefetch-file "$URL" 2>&1)
HASH=$(echo "$OUTPUT" | grep -oP "hash '\K[^']+")
echo "Hash: $HASH"

echo "Generating $DRIVER_NIX..."
sed -e "s|KOSHINVIDIAVERSION|$VERSION|" -e "s|KOSHINVIDIASHA256|$HASH|" "$TEMPLATE" > "$DRIVER_NIX"

echo "Done."
