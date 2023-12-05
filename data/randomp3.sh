#!/bin/bash


SS="$(readlink -f "$0")"
DIR="$(dirname "$SS")"

read -p "Please specify the Path to the MP3 folder you have all your MP3s in....  " SRC
master_dir="$SRC"
base_destination_dir="$DIR"


# List all .mp3 files in the master directory and shuffle the list

cp "$master_dir"/*.mp3 "$base_destinations_dir"
