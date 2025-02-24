#!/bin/bash

# Help message function
usage() {
  echo "Usage: $0 -o <output file> [-d <record desktop>] [-s <silent>]"
  exit 1
}

# Parse flags
while getopts "d:o:s" opt; do
  case ${opt} in
    d ) RECORD_SCREEN="$OPTARG";;
    o ) OUTPUT_FILE="$OPTARG";;
    s ) SILENT="$OPTARG";;
    * ) usage ;;
  esac
done

# Check if input file is provided
if [[ -z "$OUTPUT_FILE" ]]; then
  echo "Error: Output file is required!"
  usage
fi

# use `arecord -l | grep card` and set hw:<card>,<device>
AUDIO_OPTIONS='-f alsa -i plughw:1,0'
# noise filters -af "afftdn=nr=20:nf=-30,anlmdn=s=7:p=0.5" may be adjusted
if [[ -v SILENT ]]; then
  # disable for gifs
  AUDIO_OPTIONS=""
fi

if [[ -v "$RECORD_SCREEN" ]]; then
  # use `xrandr --listmonitors` to find the correct monitor value for dual monitors (`:0.0`)
  # specify left/right offset from primary monitor to capture secondary monitor :0.0+1920,0
  ffmpeg \
    -video_size 1920x1080 \
    -framerate 30 \
    -f x11grab \
    -i :0.0 \
    ${AUDIO_OPTIONS} \
    "${OUTPUT_FILE}"
else
  XWININFO=$(xwininfo)
  WINDOW_ID=$("$XWININFO" | grep -i "window id" | awk '{ print $4 }')
  WINFO=$(echo "$XWININFO" | awk '/Absolute|Width|Height/')
  ABS_X=$(echo "$WINFO" | awk '/X/ { print $4 }')
  ABS_Y=$(echo "$WINFO" | awk '/Y/ { print $4 }')
  WIDTH=$(echo "$WINFO" | awk '/Width/ { print $2 }')
  HEIGHT=$(echo "$WINFO" | awk '/Height/ { print $2 }')

  ffmpeg \
    -video_size ${WIDTH}x${HEIGHT} \
    -framerate 30 \
    -f x11grab \
    -i :0.0+${ABS_X},${ABS_Y} \
    ${AUDIO_OPTIONS} \
    "${OUTPUT_FILE}"
fi

echo "ffplay ${OUTPUT_FILE}"
