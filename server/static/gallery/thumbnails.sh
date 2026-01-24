#! /bin/bash
for f in *jpg
do
    g=$(basename $f .jpg)
    h="$g-thumb.jpg" # append thumb to file name
    cp $f $h
    echo "Copied $h."
    mogrify $h -resize 20%
done
