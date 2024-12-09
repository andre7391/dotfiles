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
#         cp $file converted/${file%%.*}-original.${file##*.}
#         magick $file -gravity center -crop 16:9 -strip -sampling-factor 4:4:4 -unsharp 0x1 -density 300 -resize x1440 -quality 95 converted/${file%%.*}.jpg
#     fi
# done