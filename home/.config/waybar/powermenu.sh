#!/bin/sh
# Меню питания для waybar (rofi)
choice=$(printf "Экран\nСпящий\nПерезагрузка\nВыключение\n" | rofi -dmenu -i -p "⏻")
case "$choice" in
    "Экран")        niri msg action power-off-monitors ;;
    "Спящий")       systemctl suspend ;;
    "Перезагрузка") systemctl reboot ;;
    "Выключение")   systemctl poweroff ;;
esac
