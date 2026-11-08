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

## как выглядит 
<img width="3434" height="1437" alt="изображение" src="https://github.com/user-attachments/assets/40fdeb12-db24-48f1-a32a-4a091425d9d4" />

<img width="3434" height="1437" alt="изображение" src="https://github.com/user-attachments/assets/2e5bf4d8-235f-43b4-8a7c-7fa94659fd95" />

<img width="3434" height="1437" alt="изображение" src="https://github.com/user-attachments/assets/00c590b1-51a9-4806-b6ea-89015a08aa76" />

<img width="3434" height="1437" alt="изображение" src="https://github.com/user-attachments/assets/62302f4a-adcc-4200-b5e4-bf72da7b1687" />


## Не включено (секреты / крупный мусор)
- `.config/Happ.conf` (VPN-данные), `.config/opencode` (API-ключи), браузеры, `.icons`, кэши.

## Обновление
После изменений в `$HOME`:
```sh
rsync -av --exclude .git --exclude README.md ~/dotfiles/home/... # наоборот:
# копировать из $HOME в репо так же, как при первичной настройке, затем:
git -C ~/dotfiles add -A && git -C ~/dotfiles commit -m "update" && git -C ~/dotfiles push
```
