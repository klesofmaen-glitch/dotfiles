#!/bin/bash

# Скрипт для адаптации темы Kitty под обои рабочего стола

THEME_FILE="$HOME/.config/kitty/themes/cosmic.conf"
BACKUP_FILE="$HOME/.config/kitty/themes/cosmic.conf.backup"

# Создаем резервную копию оригинальной темы
cp "$THEME_FILE" "$BACKUP_FILE"

echo "Анализ обоев рабочего стола..."

# Определяем путь к обоям (путь может меняться в зависимости от окружения)
WALLPAPER_PATH=""

# Проверяем различные возможные места хранения обоев
if [[ -n "$XDG_CURRENT_DESKTOP" ]]; then
    case "$XDG_CURRENT_DESKTOP" in
        *GNOME*|*ubuntu:*)
            WALLPAPER_PATH=$(gsettings get org.gnome.desktop.background picture-uri 2>/dev/null | sed "s/'//g" | sed "s/file:\/\///")
            ;;
        *KDE*)
            WALLPAPER_PATH=$(kreadconfig5 --file "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" --group "Containments" --group "1" --group "Wallpaper" --group "org.kde.image" --group "General" --group "Image" | sed "s/'//g")
            ;;
        *XFCE*)
            WALLPAPER_PATH=$(xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path 2>/dev/null)
            ;;
    esac
fi

# Если не удалось определить путь, спрашиваем пользователя
if [[ -z "$WALLPAPER_PATH" || ! -f "$WALLPAPER_PATH" ]]; then
    echo "Не удалось автоматически определить путь к обоям."
    echo "Укажите путь к файлу обоев:"
    read -r WALLPAPER_PATH
fi

# Проверяем существование файла
if [[ ! -f "$WALLPAPER_PATH" ]]; then
    echo "Ошибка: Файл обоев не найден: $WALLPAPER_PATH"
    echo "Восстанавливаем оригинальную тему..."
    cp "$BACKUP_FILE" "$THEME_FILE"
    exit 1
fi

echo "Используется обои: $WALLPAPER_PATH"

# Анализируем цветовую гамму обоев
echo "Анализируем цветовую гамму обоев..."
# Здесь можно добавить более сложный анализ цветовой гаммы
# Для простоты используем ImageMagick для извлечения основных цветов

if command -v convert &> /dev/null; then
    # Используем ImageMagick для анализа цветов
    echo "Анализируем цветовую палитру..."
    
    # Извлекаем основные цвета
    convert "$WALLPAPER_PATH" -resize 25% -colors 8 -format "%c" histogram:- | \
    grep -o '#[0-9a-fA-F]\{6\}' | sort | uniq > /tmp/colors.txt
    
    # Берем самые частые цвета
    MAIN_COLOR=$(head -n 1 /tmp/colors.txt)
    ACCENT_COLOR=$(head -n 3 /tmp/colors.txt | tail -n 1)
    
    echo "Основной цвет: $MAIN_COLOR"
    echo "Акцентный цвет: $ACCENT_COLOR"
    
    # Адаптируем тему под цвета обоев
    sed -i "s/background #0D1423/background $MAIN_COLOR/" "$THEME_FILE"
    sed -i "s/active_tab_background #8CC8FF/active_tab_background $ACCENT_COLOR/" "$THEME_FILE"
    sed -i "s/cursor #E3EDFA/cursor $ACCENT_COLOR/" "$THEME_FILE"
    
    # Создаем адаптированную версию темы
    ADAPTED_THEME="$HOME/.config/kitty/themes/cosmic-adapted.conf"
    cp "$THEME_FILE" "$ADAPTED_THEME"
    
    echo "Адаптированная тема создана: $ADAPTED_THEME"
    echo "Чтобы использовать адаптированную тему, выполните:"
    echo "~/.config/kitty/theme-switcher.sh cosmic-adapted"
    
else
    echo "ImageMagick не найден. Используем стандартные настройки."
    echo "Рекомендуется установить ImageMagick для лучшей адаптации темы:"
    echo "sudo apt install imagemagick"
fi

# Очистка временных файлов
rm -f /tmp/colors.txt

echo ""
echo "Готово! Тема адаптирована под ваши обои."
echo "Перезапустите Kitty для применения изменений."