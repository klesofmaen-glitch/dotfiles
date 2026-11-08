# Dotfiles

Персональные dot-файлы (Gentoo, Niri/Wayland, Kitty, Fish, Waybar, Rofi, Neovim).

## Состав
Структура `home/` зеркалит `$HOME` — достаточно скопировать поверх.
- `.bashrc`, `.bash_profile`, `.profile`, `.bash_logout`, `.gtkrc-2.0`
- `.config/`: fish, kitty, niri, waybar, rofi, nvim, gtk-3.0, gtk-4.0, nwg-look, xsettingsd, xdg-desktop-portal, xfce4, systemd/user, pulse, OpenRGB, Thunar, mimeapps.list
- `dconf-settings.ini` — дамп настроек GTK/Xfce (применяется: `dconf load / < dconf-settings.ini`)

## Установка на новой машине
```sh
git clone https://github.com/<username>/dotfiles.git
rsync -av --exclude .git dotfiles/home/ ~/
dconf load / < ~/home/dconf-settings.ini
```

## Не включено (секреты / крупный мусор)
- `.config/Happ.conf` (VPN-данные), `.config/opencode` (API-ключи), браузеры, `.icons`, кэши.

## Обновление
После изменений в `$HOME`:
```sh
rsync -av --exclude .git --exclude README.md ~/dotfiles/home/... # наоборот:
# копировать из $HOME в репо так же, как при первичной настройке, затем:
git -C ~/dotfiles add -A && git -C ~/dotfiles commit -m "update" && git -C ~/dotfiles push
```
