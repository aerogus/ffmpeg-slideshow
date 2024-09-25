#!/usr/bin/env bash
##
# Génération d'images fixes
##

declare -A colors=(
    ["0xFFFFFF@1.0"]="white"
    ["0x000000@1.0"]="black"
    ["0xFF00CC@1.0"]="pink"
    ["0xFF0000@1.0"]="red"
    ["0x00FF00@1.0"]="green"
    ["0x0000FF@1.0"]="blue"
    ["0x000000@0.0"]="transparent"
)

# export ok pour png,jpg,webp
# todo: optimiser la palette si export gif
for color in "${!colors[@]}"; do
    echo "- Génération ${colors[$color]}.png : $color"
    ffmpeg -y -f lavfi -i "color=color=$color:size=320x240,format=rgba" -update 1 -vframes 1 "${colors[$color]}.png"
done
