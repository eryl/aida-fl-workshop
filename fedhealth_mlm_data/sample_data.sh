#!/bin/bash

# Check if the correct number of arguments is given
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_subdir> <output_dir>"
    exit 1
fi

SUBDIR="$1"
OUTDIR="$2"

# Make sure output directory exists
mkdir -p "$OUTDIR"

# Loop through each .txt file in the subdirectory
find "$SUBDIR" -type f -name "*.txt" | while read -r file; do
    total_lines=$(wc -l < "$file")
    sample_size=$(( (total_lines + 19) / 20 ))  # 10% rounded up

    # Construct the output file path
    filename=$(basename "$file")
    output_file="$OUTDIR/$filename"

    # Take the first 10% of lines
    head -n "$sample_size" "$file" > "$output_file"

    echo "Sampled first $sample_size lines from $filename -> $output_file"
done
