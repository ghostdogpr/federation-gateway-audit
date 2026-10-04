#!/usr/bin/env bash
set -euo pipefail

# https://github.com/VirtusLab/scala-cli/releases
SCALA_CLI_VERSION="1.17.1"

if [[ ! -x ./scala-cli ]]; then
    case $(uname -ms) in
    'Darwin arm64') target=aarch64-apple-darwin ;;
    'Darwin x86_64') target=x86_64-apple-darwin ;;
    'Linux aarch64' | 'Linux arm64') target=aarch64-pc-linux ;;
    *) target=x86_64-pc-linux ;;
    esac
    curl -fsSL "https://github.com/VirtusLab/scala-cli/releases/download/v$SCALA_CLI_VERSION/scala-cli-$target.gz" | gunzip > ./scala-cli
    chmod +x ./scala-cli
fi

./scala-cli --power package --server=false --assembly Main.scala -o caliban.jar -f
