#!/run/current-system/sw/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run "betterlockscreen -u ~/.config/awesome/themes/powerarrow-blue/wallpaper.jpg"
run "betterlockscreen -l dim --off 3"
while true
do
	if ! grep -q open /proc/acpi/button/lid/LID0/state; then
        betterlockscreen -l dim --off 3
	fi
done

# download and set wallaper using feh
img_today="https://www.bing.com$(curl -sL https://www.bing.com | grep -Eo '/th\?id=[a-zA-Z0-9?%.?%_?%-]*' |grep '1080' | head -n 1)"
wall_dir="/tmp/bing_wall"

echo "Fetching today's image !"
rm -rf $wall_dir && mkdir -p $wall_dir
wget -q -P $wall_dir $img_today
mv $(readlink -f $wall_dir/*) $wall_dir/$(readlink -f $wall_dir/*|cut -d'.' -f2).jpg
feh --bg-fill $wall_dir/*

# && echo $? returns 0 if open if found
#searches for open in the above file if found return 1 thus executing betterlockscreen

#run "xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal"
#run "xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off"
#run "nm-applet"
#run "caffeine"
#run "xfce4-power-manager"
#run "blueberry-tray"
#run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
#run "numlockx on"
#run "volumeicon"
#run "nitrogen --restore"
#run "conky -c $HOME/.config/awesome/system-overview"

#run applications from startup
#run "firefox"
#run "atom"
#run "dropbox"
#run "insync start"
#run "spotify"
