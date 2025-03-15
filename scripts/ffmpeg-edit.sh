#!/bin/bash

# Video Editor Script using FFmpeg
# This script provides functionality for:
#   - Trimming videos
#   - Merging multiple videos
#   - Adding background music
#   - Adding banner text
#   - Audio normalization and noise reduction

set -e

# Display help information
show_help() {
    echo "Video Editor Script"
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -i, --input FILE       Input video file"
    echo "  -o, --output FILE      Output video file"
    echo "  --trim START END       Trim video (format: HH:MM:SS.mmm)"
    echo "                        START: remove content before this time"
    echo "                        END: remove content after this time"
    echo "  --merge FILE1,FILE2    Merge multiple video files (comma-separated)"
    echo "  --merge-list FILE      Merge videos listed in a text file (one path per line)"
    echo "  --audio FILE           Add background audio"
    echo "  --audio-volume LEVEL   Set audio volume (default: 0.2, range: 0-1)"
    echo "  --text TEXT            Add banner text at the top"
    echo "  --text-color COLOR     Set text color (default: white)"
    echo "  --text-size SIZE       Set text size (default: 24)"
    echo "  --text-bold           Use bold font for banner text"
    echo "  --normalize-audio      Normalize audio levels"
    echo "  --reduce-noise         Apply noise reduction filter"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -i input.mp4 -o output.mp4 --trim 00:00:10 00:01:30  # Keep only content between 10 sec and 1 min 30 sec"
    echo "  $0 -i input.mp4 -o output.mp4 --trim 00:00:10           # Remove first 10 seconds, keep the rest"
    echo "  $0 -i input.mp4 -o output.mp4 --trim \"\" 00:01:30        # Keep only the first 1 min 30 sec"
    echo "  $0 --merge video1.mp4,video2.mp4,video3.mp4 -o merged.mp4"
    echo "  $0 --merge-list videos.txt -o merged.mp4         # videos.txt contains one video file path per line"
    echo "  $0 -i input.mp4 -o output.mp4 --audio music.mp3 --audio-volume 0.3"
    echo "  $0 -i input.mp4 -o output.mp4 --text \"My Awesome Video\" --text-color yellow"
    echo "  $0 -i input.mp4 -o output.mp4 --normalize-audio --reduce-noise"
    exit 0
}

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install it first."
    exit 1
fi

# Default values
INPUT_FILE=""
OUTPUT_FILE=""
TRIM_START=""
TRIM_END=""
MERGE_FILES=""
MERGE_LIST=""
AUDIO_FILE=""
AUDIO_VOLUME=0.2
BANNER_TEXT=""
TEXT_COLOR="white"
TEXT_SIZE=24
TEXT_BOLD=false
NORMALIZE_AUDIO=false
REDUCE_NOISE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--input)
            INPUT_FILE="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        --trim)
            if [[ -n "$2" && "$2" != --* ]]; then
                TRIM_START="$2"
                shift
            else
                TRIM_START=""
            fi

            if [[ -n "$2" && "$2" != --* ]]; then
                TRIM_END="$2"
                shift
            else
                TRIM_END=""
            fi
            shift
            ;;
        --merge)
            MERGE_FILES="$2"
            shift 2
            ;;
        --merge-list)
            MERGE_LIST="$2"
            shift 2
            ;;
        --audio)
            AUDIO_FILE="$2"
            shift 2
            ;;
        --audio-volume)
            AUDIO_VOLUME="$2"
            shift 2
            ;;
        --text)
            BANNER_TEXT="$2"
            shift 2
            ;;
        --text-color)
            TEXT_COLOR="$2"
            shift 2
            ;;
        --text-size)
            TEXT_SIZE="$2"
            shift 2
            ;;
        --text-bold)
            TEXT_BOLD=true
            shift
            ;;
        --normalize-audio)
            NORMALIZE_AUDIO=true
            shift
            ;;
        --reduce-noise)
            REDUCE_NOISE=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
done

# Check if output file is specified
if [ -z "$OUTPUT_FILE" ]; then
    echo "Error: Output file not specified. Use -o or --output option."
    exit 1
fi

# Create temporary directory for intermediate files
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Function to trim video
trim_video() {
    local input_file="$1"
    local output_file="$2"
    local start_time="$3"
    local end_time="$4"

    echo "Trimming video from $start_time to $end_time..."

    # For start trimming, we remove content from beginning to start_time
    # For end trimming, we remove content from end_time to the end

    # Create a temporary file for processing
    local temp_file="${TEMP_DIR}/temp_trim.mp4"

    # Get the duration of the input file
    local duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_file")

    if [ -n "$start_time" ] && [ -n "$end_time" ]; then
        # Both start and end times provided - extract the segment between them
        ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c:v libx264 -c:a aac -map 0:v -map 0:a? "$output_file"
    elif [ -n "$start_time" ]; then
        # Only start time provided - remove content from beginning to start_time
        ffmpeg -i "$input_file" -ss "$start_time" -c:v libx264 -c:a aac -map 0:v -map 0:a? "$output_file"
    elif [ -n "$end_time" ]; then
        # Only end time provided - keep content from beginning to end_time
        ffmpeg -i "$input_file" -to "$end_time" -c:v libx264 -c:a aac -map 0:v -map 0:a? "$output_file"
    fi
}

# Function to merge videos from a comma-separated list
merge_videos() {
    local file_list="$1"
    local output_file="$2"
    local concat_file="${TEMP_DIR}/concat_list.txt"

    echo "Merging videos from comma-separated list..."

    # Create a file list for ffmpeg
    IFS=',' read -ra FILES <<< "$file_list"
    for file in "${FILES[@]}"; do
        echo "file '$(realpath "$file")'" >> "$concat_file"
    done

    # Merge the videos
    ffmpeg -f concat -safe 0 -i "$concat_file" -c copy "$output_file"
}

# Function to merge videos from a text file
merge_videos_from_file() {
    local list_file="$1"
    local output_file="$2"
    local concat_file="${TEMP_DIR}/concat_list.txt"

    echo "Merging videos from list file: $list_file"

    # Check if the list file exists
    if [ ! -f "$list_file" ]; then
        echo "Error: Video list file '$list_file' not found."
        exit 1
    fi

    # Create a file list for ffmpeg in the required format
    while IFS= read -r file || [ -n "$file" ]; do
        # Skip empty lines and comments
        if [[ -n "$file" && ! "$file" =~ ^[[:space:]]*# ]]; then
            # Trim leading/trailing whitespace
            file=$(echo "$file" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

            # Check if the file exists
            if [ -f "$file" ]; then
                echo "file '$(realpath "$file")'" >> "$concat_file"
                echo "Adding: $file"
            else
                echo "Warning: File '$file' not found, skipping."
            fi
        fi
    done < "$list_file"

    # Check if any valid files were found
    if [ ! -s "$concat_file" ]; then
        echo "Error: No valid video files found in '$list_file'."
        exit 1
    fi

    # Merge the videos
    ffmpeg -f concat -safe 0 -i "$concat_file" -c copy "$output_file"
}

# Function to add background audio
add_background_audio() {
    local input_file="$1"
    local audio_file="$2"
    local output_file="$3"
    local volume="$4"

    echo "Adding background audio with volume $volume..."

    # Get video duration
    local duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_file")

    # Add background audio and mix with original audio
    ffmpeg -i "$input_file" -i "$audio_file" -filter_complex \
        "[1:a]aloop=loop=-1:size=2e+09,asetpts=N/SR/TB,volume=$volume[a1]; \
         [0:a][a1]amix=inputs=2:duration=longest[a]" \
        -map 0:v -map "[a]" -shortest -t "$duration" -c:v copy -c:a aac "$output_file"
}

# Function to add banner text
add_banner_text() {
    local input_file="$1"
    local output_file="$2"
    local text="$3"
    local color="$4"
    local size="$5"
    local bold="$6"

    echo "Adding banner text: '$text'..."

    # Set font based on bold option
    local font_option=""
    if [ "$bold" = true ]; then
        # Use a bold font variant
        font_option=":fontweight=bold"
        echo "Using bold text..."
    fi

    # Add text overlay at the top center of the video
    ffmpeg -i "$input_file" -vf \
        "drawtext=text='$text':fontcolor=$color:fontsize=$size$font_option:x=(w-text_w)/2:y=10:box=1:boxcolor=black@0.5:boxborderw=5" \
        -c:a copy "$output_file"
}

# Function to normalize audio
normalize_audio() {
    local input_file="$1"
    local output_file="$2"

    echo "Normalizing audio levels..."

    # Apply loudnorm filter for EBU R128 loudness normalization
    ffmpeg -i "$input_file" -af "loudnorm=I=-16:TP=-1.5:LRA=11" -c:v copy "$output_file"
}

# Function to reduce background noise
reduce_noise() {
    local input_file="$1"
    local output_file="$2"

    echo "Reducing background noise..."

    # Apply noise reduction filter
    ffmpeg -i "$input_file" -af "afftdn=nf=-25" -c:v copy "$output_file"
}

# Process the operations in sequence
CURRENT_FILE=""

# Handle merging videos
if [ -n "$MERGE_FILES" ]; then
    MERGED_FILE="${TEMP_DIR}/merged.mp4"
    merge_videos "$MERGE_FILES" "$MERGED_FILE"
    CURRENT_FILE="$MERGED_FILE"
elif [ -n "$MERGE_LIST" ]; then
    MERGED_FILE="${TEMP_DIR}/merged.mp4"
    merge_videos_from_file "$MERGE_LIST" "$MERGED_FILE"
    CURRENT_FILE="$MERGED_FILE"
else
    if [ -z "$INPUT_FILE" ]; then
        echo "Error: Input file not specified. Use -i or --input option."
        exit 1
    fi
    CURRENT_FILE="$INPUT_FILE"
fi

# Handle trimming
if [ -n "$TRIM_START" ]; then
    TRIMMED_FILE="${TEMP_DIR}/trimmed.mp4"
    trim_video "$CURRENT_FILE" "$TRIMMED_FILE" "$TRIM_START" "$TRIM_END"
    CURRENT_FILE="$TRIMMED_FILE"
fi

# Handle audio normalization
if [ "$NORMALIZE_AUDIO" = true ]; then
    NORMALIZED_FILE="${TEMP_DIR}/normalized.mp4"
    normalize_audio "$CURRENT_FILE" "$NORMALIZED_FILE"
    CURRENT_FILE="$NORMALIZED_FILE"
fi

# Handle noise reduction
if [ "$REDUCE_NOISE" = true ]; then
    NOISE_REDUCED_FILE="${TEMP_DIR}/noise_reduced.mp4"
    reduce_noise "$CURRENT_FILE" "$NOISE_REDUCED_FILE"
    CURRENT_FILE="$NOISE_REDUCED_FILE"
fi

# Handle adding background audio
if [ -n "$AUDIO_FILE" ]; then
    WITH_AUDIO_FILE="${TEMP_DIR}/with_audio.mp4"
    add_background_audio "$CURRENT_FILE" "$AUDIO_FILE" "$WITH_AUDIO_FILE" "$AUDIO_VOLUME"
    CURRENT_FILE="$WITH_AUDIO_FILE"
fi

# Handle adding banner text
if [ -n "$BANNER_TEXT" ]; then
    WITH_TEXT_FILE="${TEMP_DIR}/with_text.mp4"
    add_banner_text "$CURRENT_FILE" "$WITH_TEXT_FILE" "$BANNER_TEXT" "$TEXT_COLOR" "$TEXT_SIZE" "$TEXT_BOLD"
    CURRENT_FILE="$WITH_TEXT_FILE"
fi

# Create the final output
cp "$CURRENT_FILE" "$OUTPUT_FILE"

echo "Video processing completed: $OUTPUT_FILE"
