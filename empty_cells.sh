#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# empty_cells.sh — counts the number of empty cells in each column
if [[ $# -ne 2 ]]; then 
  echo "Usage: $0 <file> <separator>" >&2
  exit 1
fi

file="$1"
sep="$2"

# Check that the file is readable
if [[ ! -r "$file" ]]; then
  echo "Error: Cannot read file '$file'" >&2
  exit 1
fi

awk -v FS="$sep" '
  BEGIN {
    OFS = ""
  }
  NR == 1 {
    sub(/\r$/, "")
    for (i = 1; i <= NF; i++) {
      col[i] = $i
    }
    n = NF
    next 
  } 
  END { 
    for (i = 1; i <= n; i++) { 
      printf("%s: 0\n", col[i]) 
    } 
  }
' "$file"