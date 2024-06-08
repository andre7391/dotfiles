#!/usr/bin/env zsh

# wallpapers
symlink $dir/wallhaven ~/.config/wallpapers

# # commands to convert images with imagemagick
# for file in * ; do
#     # echo $file
#     # file $file | grep -v "2560 x 1440" | grep -v "2560x1440" 
#     if [[ -f $file ]] ; then
#         file $file
#         magick $file -strip -sampling-factor 4:4:4 -interlace Plane -resize x1440 -quality 95 converted/${file%%.*}.jpg
#     fi
# done

