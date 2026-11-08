#!/bin/bash

# Скрипт для быстрой смены тем Kitty в стиле Cosmic

THEME_DIR="$HOME/.config/kitty/themes"
CURRENT_THEME_FILE="$HOME/.config/kitty/current-theme.conf"
KITTY_CONF="$HOME/.config/kitty/kitty.conf"

# Доступные темы
declare -A THEMES=(
    ["cosmic"]="themes/cosmic.conf"
    ["noctalia"]="themes/noctalia.conf"
    ["station"]="themes/station.conf"
)

# Функция для отображения доступных тем
show_themes() {
    echo "Доступные темы:"
    for theme in "${!THEMES[@]}"; do
        if [[ "$theme" == "$(get_current_theme)" ]]; then
            echo "  * $theme (текущая)"
        else
            echo "  - $theme"
        fi
    done
}

# Функция для получения текущей темы
get_current_theme() {
    if grep -q "include.*themes/" "$KITTY_CONF"; then
        local theme_line=$(grep "include.*themes/" "$KITTY_CONF")
        local theme_file=$(echo "$theme_line" | sed 's/.*include[[:space:]]*\(.*\)/\1/')
        theme_file=$(basename "$theme_file" .conf)
        echo "$theme_file"
    else
        echo "unknown"
    fi
}

# Функция для смены темы
switch_theme() {
    local theme_name="$1"
    
    if [[ -z "$theme_name" ]]; then
        echo "Ошибка: Не указано имя темы"
        show_themes
        return 1
    fi
    
    if [[ ! -v THEMES["$theme_name"] ]]; then
        echo "Ошибка: Тема '$theme_name' не найдена"
        show_themes
        return 1
    fi
    
    # Обновляем конфигурацию Kitty
    sed -i "s|include.*themes/.*|include ${THEMES[$theme_name]}|" "$KITTY_CONF"
    
    # Обновляем файл текущей темы
    cat > "$CURRENT_THEME_FILE" << EOF
# Cosmic Theme - Current
# Тема: $theme_name
# Цвета импортируются из ${THEMES[$theme_name]}
# Не редактировать этот файл вручную

# Основные настройки
cursor                #E3EDFA
cursor_text_color     #0D1423
background            #0D1423
foreground            #E3EDFA
selection_foreground  #7E96B8
selection_background  #43474c
active_border_color   #8CC8FF
inactive_border_color   #1E2F4A
url_color             #8CC8FF

# Панель вкладок
active_tab_foreground   #0D1423
active_tab_background   #8CC8FF
inactive_tab_foreground #7E96B8
inactive_tab_background #1E2F4A
cursor_trail_color      #7E96B8
EOF
    
    echo "Тема изменена на: $theme_name"
    echo "Перезапустите Kitty для применения изменений"
}

# Основная логика
case "${1:-}" in
    "list")
        show_themes
        ;;
    "current")
        get_current_theme
        ;;
    *)
        switch_theme "$1"
        ;;
esac