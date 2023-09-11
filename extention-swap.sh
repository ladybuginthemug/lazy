#!/bin/bash


usage() {
    echo "Usage: $0 [-f filename] [-e extension] [-n new_extension] [-h help]"
    echo "Options:"
    echo "  -f filename       Specify a specific filename to search for "
    echo "  -e extension      Specify the file extension to search for "
    echo "  -n new_extension  Specify the new file extension to rename to "
    exit 1
}


extension=""
filename=""
new_extension=""


while getopts "f:e:n:h" opt; do
    case "$opt" in
        f)
            filename="$OPTARG"
            ;;
        e)
            extension="$OPTARG"
            ;;
        n)
            new_extension="$OPTARG"
            ;;
        h)
            usage
            ;;
    esac
done


shift $((OPTIND-1))


if [ -z "$extension" ] && [ -z "$filename" ]; then
    echo "Error: Please specify an extension or a file name"
    
    usage
fi



if [ -n "$filename" ]; then
    for file in "$filename".*; do
        if [ -f "$file" ]; then
            base_name=$(basename "$file")
            new_name="${base_name%.*}.$new_extension"
            mv "$file" "$new_name"
            echo "Renamed: $file -> $new_name"
        fi
    done
fi


if [ -n "$extension" ]; then
    for file in *."$extension"; do
        if [ -f "$file" ]; then
            base_name=$(basename "$file")
            new_name="${base_name%.*}.$new_extension"
            mv "$file" "$new_name"
            echo "Renamed: $file -> $new_name"
        fi
    done
fi