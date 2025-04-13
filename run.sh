#!/usr/bin/env bash
##
# Générateur d'une vidéo à partir d'un scénario
##

declare -r  VIDEO_BACKGROUND_COLOR="0x292933"
declare -ri VIDEO_LENGTH=10
declare -ri VIDEO_WIDTH=640
declare -ri VIDEO_HEIGHT=360
declare -ri VIDEO_FRAMERATE=25
declare -r  VIDEO_SCENARIO="scenario.txt"
declare -r  VIDEO_OUTPUT="output.mp4"
declare -rA COLORS=(
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
for color in "${!COLORS[@]}"; do
    echo "- Génération ${COLORS[$color]}.png : $color"
    ffmpeg -hide_banner -loglevel error -y -f lavfi -i "color=color=$color:size=320x240,format=rgba" -update 1 -vframes 1 "${COLORS[$color]}.png"
done

# fond sombre, durée totale de 10s, placement de l'overlay + ajout timecode
echo "- Génération ${VIDEO_OUTPUT}"
ffmpeg -hide_banner -loglevel error -y \
-f lavfi -i "color=color=${VIDEO_BACKGROUND_COLOR}:d=${VIDEO_LENGTH}:size=${VIDEO_WIDTH}x${VIDEO_HEIGHT}:rate=${VIDEO_FRAMERATE}" \
-f concat -i "${VIDEO_SCENARIO}" \
-filter_complex "overlay=x=20:y=20 [main]; \
 [main] drawtext=fontsize=72:fontcolor=yellow:text='%{pts\:hms}':x=(w-tw)/2:y=(h-th)/2;" \
-pix_fmt yuv420p \
-r $VIDEO_FRAMERATE \
"${VIDEO_OUTPUT}"

# ménage
for color in "${!COLORS[@]}"; do
    echo "- Ménage ${COLORS[$color]}.png"
    rm "${COLORS[$color]}.png"
done
