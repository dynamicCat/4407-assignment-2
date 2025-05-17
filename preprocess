#!/usr/bin/env bash
set -euo pipefail

# preprocess.sh — Clean the dataset

if [[ $# -ne 1 ]]; then 
  echo "Usage: $0 <file>" >&2 
  exit 1
fi
file="$1"
if [[ ! -r "$file" ]]; then 
  echo "Error: Cannot read '$file'" >&2 
  exit 1
fi

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

# CRLF → LF
sed -E -e 's/\r$//' "$file" > "$tmp"

cat "$tmp"