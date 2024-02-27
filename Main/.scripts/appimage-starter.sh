#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <search_word>"
  exit 1
fi

search_word=$1
app_dir=".appimages"

# Check if the directory exists
if [ ! -d "$app_dir" ]; then
  echo "Directory $app_dir not found."
  exit 1
fi

# Search for AppImages containing the specified word
app_images=$(find "$app_dir" -iname "*.appimage" -type f | grep "$search_word")

if [ -z "$app_images" ]; then
  echo "No AppImages found containing the word '$search_word' in the name."
  exit 1
fi

# Execute the found AppImages
echo "Executing AppImages containing the word '$search_word':"
for app_image in $app_images; do
  chmod +x "$app_image"
  ./"$app_image" &
done

echo "Execution complete."
