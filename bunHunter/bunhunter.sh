#!/usr/bin/env bash

declare -a files=(
   setup_bun.js,
   bun_environment.js
)

echo "Enter the target directory to scan:"
read TargetDir

echo "... checking for bun signature ..."

for file in ${files[@]}; do
    find $TargetDir -name "$file" >> bun_files_found.txt
done

if [ ! -s bun_files_found.txt ]; then
    echo "No Bun-related files found."
    echo "No Bun-related files found." >> bun_files_found.txt
    echo "script done"
    exit 0
fi

echo "Bun hunt output:"
cat bun_files_found.txt

echo "script done"
