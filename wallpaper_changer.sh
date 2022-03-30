#!/usr/bin/env bash

img_today="https://www.bing.com$(curl -sL https://www.bing.com | grep -Eo '/th\?id=[a-zA-Z0-9?%.?%_?%-]*' |grep '1080' | head -n 1)"
wall_dir="/tmp/bing_wall"

echo "Fetching today's image !"
rm -rf $wall_dir && mkdir -p $wall_dir
wget -q -P $wall_dir $img_today
mv $(readlink -f $wall_dir/*) $wall_dir/$(readlink -f $wall_dir/*|cut -d'.' -f2).jpg

#feh --bg-fill $wall_dir/*
swaybg -i $wall_dir/* -m fill &
