#!/usr/bin/env zsh

# wallpapers
symlink $dir/wallhaven ~/.config/wallpapers/wallhaven
symlink $dir/unplash ~/.config/wallpapers/unplash

# # commands to convert images with imagemagick
# for file in * ; do
#     # echo $file
#     # file $file 
#     if [[ -f $file ]] ; then
#         file $file
#         magick $file -gravity center -crop 16:9 -strip -sampling-factor 4:4:4 -interlace Plane -resize x1440 -quality 95 converted/${file%%.*}.jpg
#     fi
# done