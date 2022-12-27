#!/bin/sh

list=$(wmctrl -l | grep -E '0x[0-9a-f]* *0 .*' | cut -d' ' -f1,5- | sed -z 's=\n=\\n=g')
list=${list::-2}
choice=$(printf "$list" | dmenu -l 30 | cut -d ' ' -f1)
dec=$(printf "%i" $choice)
xdotool windowactivate $dec
choice=$(printf "Continuer\nAnnuler" | dmenu -l 30)
echo $choice
if [ "$choice" = "Continuer" ]; then
  xdotool type --window $dec "$(xclip -out -sel c)";
  echo "Text copied successfully !"
else
  echo "Aborted !"
fi
