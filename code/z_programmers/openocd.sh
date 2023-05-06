#!/usr/bin/env bash
set -e
if [ -z "$1" ]; then
  echo "Error: No file path provided. Usage: $0 <file_path>"
  exit 1
fi

if [ ! -e "$1" ]; then
  echo "The file '$1' should exist."
  exit 2
fi

openocd -f ./jtag.cfg -c "svf -quiet -progress $1"
