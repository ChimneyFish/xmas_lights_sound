#!/bin/bash

SS="$(readlink -f "$0")"
DIR="$(dirname "$SS")"
sudo apt update && sudo apt install openjdk-17-jdk
chmod +x "$DIR"/data/randomp3.sh
read -p "do you want to pull all mp3s from a single folder, press one for yes, press any other key to exit and place MP3s manualy" N
if ( "$N" = 1 ); then
./"$DIR"/data/randomp3.sh
else 
exit 
