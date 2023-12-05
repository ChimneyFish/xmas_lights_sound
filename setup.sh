#!/bin/bash

SS="$(readlink -f "$0")"
DIR="$(dirname "$SS")"
sudo apt update && sudo apt install openjdk-17-jdk alsa* python3 
chmod +x "$DIR"/data/randomp3.sh
read -p "Do you want to pull all mp3s from a single folder? Press 1 for yes, press any other key to exit and place MP3s manually: " N

if [ "$N" -eq 1 ]; then
    ./"$DIR"/data/randomp3.sh
else
    exit
fi
