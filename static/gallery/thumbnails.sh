#! /bin/bash

# Remove spaces from all filenames
for f in *; do
    if [[ "$f" == *" "* ]]; then
        newf="${f// /_}"
        mv "$f" "$newf"
        echo "Renamed '$f' to '$newf'"
    fi
done

# Convert all non-jpg images to jpg (png, jpeg, heic, etc.)
for img in *.{png,jpeg,heic,HEIC,PNG,JPEG}; do
    [ -e "$img" ] || continue
    base="${img%.*}"
    # Convert to jpg if not already
    if [[ ! -f "$base.jpg" ]]; then
        echo "Converting $img to $base.jpg"
        magick "$img" "$base.jpg"
    fi
done

# Remove any existing thumbnails
rm -f *-thumb.jpg

# Now create thumbnails from all jpg images, skipping those already ending with -thumb.jpg
for f in *.jpg; do
    [ -e "$f" ] || continue
    # Skip files that are already thumbnails
    if [[ "$f" == *-thumb.jpg ]]; then
        continue
    fi
    g="${f%.jpg}"
    h="$g-thumb.jpg"
    cp "$f" "$h"
    echo "Copied $h."
    mogrify "$h" -resize 20%
done
