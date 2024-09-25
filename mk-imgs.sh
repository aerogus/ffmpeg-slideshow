#!/usr/bin/env bash
##
# Génération d'images fixes
##

declare -A colors=(
    ["FFFFFF"]="white"
    ["000000"]="black"
    ["FF00CC"]="pink"
    ["FF0000"]="red"
    ["00FF00"]="green"
    ["0000FF"]="blue"
)

# export ok pour png,jpg,webp
# todo: optimiser la palette si export gif
for color in "${!colors[@]}"; do
    echo "- Génération ${colors[$color]}.png : $color"
    ffmpeg -y -f lavfi -i "color=color=0x$color:size=320x240" -pix_fmt rgba -update 1 -vframes 1 "${colors[$color]}.png"
done
