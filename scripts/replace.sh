#!/bin/bash
usage() {
  echo "Usage: $0 -f <find> -r <replace> [-w]"
  echo "  -f <find>      Pattern to find"
  echo "  -r <replace>   Text to replace with"
  echo "  -w             Write changes (default is dry run mode)"
  exit 1
}

# Initialize variables
DRY_RUN=true

while getopts "f:r:w" opt; do
  case ${opt} in
    f) FIND="$OPTARG";;
    r) REPLACE="$OPTARG";;
    w) DRY_RUN=false;;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    *) usage ;;
  esac
done

if [ -z "$FIND" ] || [ -z "$REPLACE" ]; then
  usage
fi

# Find files containing the pattern
FILES=$(rg "$FIND" -l)

# Check if any files were found
if [ -z "$FILES" ]; then
  echo "No files found containing the pattern: $FIND"
  exit 0
fi

if [ "$DRY_RUN" = true ]; then
  echo "DRY RUN: The following changes would be made:"
  echo "-------------------------------------------"
  for FILE in $FILES; do
    echo "File: $FILE"
    # Show differences that would be made using diff
    sed "s#${FIND}#${REPLACE}#g" "$FILE" | diff -u "$FILE" -
    echo ""
  done
  echo "-------------------------------------------"
  echo "DRY RUN: No actual changes were made."
else
  echo "Replacing '$FIND' with '$REPLACE' in the following files:"
  echo "$FILES" | tr ' ' '\n'
  # Actually perform the replacements
  sed -i "s#${FIND}#${REPLACE}#g" $FILES
  echo "Replacements complete."
fi
