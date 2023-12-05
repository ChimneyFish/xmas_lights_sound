#!/bin/bash

SS="$(readlink -f "$0")"
DIR="$(dirname "$SS")"
INTP="$DIR"/processing-4.3/install.sh
song_move="$DIR"/data/randomp3.sh
#
sudo apt update && sudo apt install openjdk-17-jdk alsa* python3 -y
chmod +x "$DIR"/data/randomp3.sh
wget https://github.com/processing/processing4/releases/download/processing-1293-4.3/processing-4.3-linux-x64.tgz && tar -xf processing-1293-4.3/processing-4.3-linux-x64.tgz && 
$INTP
#
read -p "Do you want to pull all mp3s from a single folder? Press 1 for yes, press any other key to exit and place MP3s manually: " N
#
if [ "$N" -eq 1 ]; then
    "$DIR"/data/randomp3.sh
else
    exit
fi
