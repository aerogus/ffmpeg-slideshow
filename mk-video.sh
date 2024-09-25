#!/usr/bin/env bash
##
# Générateur d'une vidéo à partir d'un scénario
##

VIDEO_BACKGROUND_COLOR="0x292933"
VIDEO_LENGTH=10
VIDEO_WIDTH=640
VIDEO_HEIGHT=360
VIDEO_FRAMERATE=25
VIDEO_SCENARIO="scenario.txt"
VIDEO_OUTPUT="output.mp4"

# fond sombre, durée totale de 10s, placement de l'overlay + ajout timecode
ffmpeg -y \
-f lavfi -i "color=color=${VIDEO_BACKGROUND_COLOR}:d=${VIDEO_LENGTH}:size=${VIDEO_WIDTH}x${VIDEO_HEIGHT}:rate=${VIDEO_FRAMERATE}" \
-f concat -i "${VIDEO_SCENARIO}" \
-filter_complex "overlay=x=20:y=20 [main]; \
 [main] drawtext=fontsize=72:fontcolor=yellow:text='%{pts\:hms}':x=(w-tw)/2:y=(h-th)/2;" \
-pix_fmt yuv420p \
-r $VIDEO_FRAMERATE \
"${VIDEO_OUTPUT}"
