#!/usr/bin/env bash

wallDIR="$HOME/.dotfiles/.misc/Pictures/tokyonight"
cache_dir="$HOME/.config/hypr/.cache"
themes_dir="$HOME/.config/hypr/.cache/colors"

# Transition config
FPS=60
TYPE="any"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"


# Retrieve image files
PICS=($(ls "${wallDIR}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))

# Rofi command ( style )
rofi_command1="rofi -show -dmenu -config ~/.config/rofi/rofi-wall.rasi"

menu() {
  for i in "${!PICS[@]}"; do
    # Displaying .gif to indicate animated images
    if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
      printf "$(echo "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${wallDIR}/${PICS[$i]}\n"
    else
      printf "${PICS[$i]}\n"
    fi
  done

}

choice=$(menu | ${rofi_command1})

swww query || swww init

# No choice case
if [[ -z $choice ]]; then
  exit 0
fi

# Find the index of the selected file
pic_index=-1
for i in "${!PICS[@]}"; do
  if [[ "${PICS[$i]}" == "$choice"* ]]; then
    pic_index=$i
    break
  fi
done

if [[ $pic_index -ne -1 ]]; then
    # notify-send -i "${wallDIR}/${PICS[$pic_index]}" "Changing wallpaper" -t 1500
    swww img "${wallDIR}/${PICS[$pic_index]}" $SWWW_PARAMS

    ln -sf "${wallDIR}/${PICS[$pic_index]}" "$cache_dir/current_wallpaper.png"

else
    echo "Image not found."
    exit 1
fi

sleep 0.5
