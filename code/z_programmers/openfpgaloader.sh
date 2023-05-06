#!/usr/bin/env bash
set -e
CABLE=dirtyJtag
BOARD=colorlight
FREQUENCY=16000000

if [ -z "$1" ]; then
  echo "Error: No file path provided. Usage: $0 <file_path>"
  exit 1
fi

if [ ! -e "$1" ]; then
  echo "The file '$1' should exist."
  exit 2
fi

openFPGALoader -c "$CABLE" -b "$BOARD" --freq "$FREQUENCY" $1
