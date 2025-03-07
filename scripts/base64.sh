#!/bin/bash

# Function to print usage information
print_usage() {
    echo "Usage: $0 [-e|-d] [-p] <string>"
    echo "  -e: Encode the string (default if not specified)"
    echo "  -d: Decode the string"
    echo "  -p: Add padding if required (for decoding)"
    echo "Example: $0 -e 'Hello World'"
    echo "Example: $0 -d -p 'SGVsbG8gV29ybGQ'"
}

# Default options
OPERATION="encode"
FIX_PADDING=false

# Parse command line options
while getopts ":edph" opt; do
    case ${opt} in
        e)
            OPERATION="encode"
            ;;
        d)
            OPERATION="decode"
            ;;
        p)
            FIX_PADDING=true
            ;;
        h)
            print_usage
            exit 0
            ;;
        \?)
            echo "Invalid option: $OPTARG" >&2
            print_usage
            exit 1
            ;;
    esac
done

# Remove the parsed options
shift $((OPTIND -1))

# Check if a string is provided
if [ $# -lt 1 ]; then
    echo "Error: No input string provided." >&2
    print_usage
    exit 1
fi

# Get the input string
INPUT="$1"

# Function to add base64 padding if needed
add_padding() {
    local str="$1"
    local mod=$((${#str} % 4))

    if [ $mod -eq 0 ]; then
        echo "$str"
    elif [ $mod -eq 2 ]; then
        echo "${str}=="
    elif [ $mod -eq 3 ]; then
        echo "${str}="
    else
        echo "$str"
    fi
}

# Perform the operation
if [ "$OPERATION" = "encode" ]; then
    # Encode
    RESULT=$(echo -n "$INPUT" | base64)
    echo "$RESULT"
elif [ "$OPERATION" = "decode" ]; then
    # Fix padding if requested
    if [ "$FIX_PADDING" = true ]; then
        INPUT=$(add_padding "$INPUT")
    fi

    # Decode
    RESULT=$(echo -n "$INPUT" | base64 --decode)
    echo "$RESULT"
fi

exit 0
