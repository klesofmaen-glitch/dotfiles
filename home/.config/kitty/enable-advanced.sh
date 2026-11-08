#!/bin/bash

# Скрипт для включения продвинутых настроек Kitty

KITTY_CONF="$HOME/.config/kitty/kitty.conf"

# Проверяем, подключены ли уже продвинутые настройки
if grep -q "include advanced.conf" "$KITTY_CONF"; then
    echo "Продвинутые настройки уже включены"
    exit 0
fi

# Добавляем подключение продвинутых настроек в конец файла
echo "" >> "$KITTY_CONF"
echo "# ===== Продвинутые настройки =====" >> "$KITTY_CONF"
echo "include advanced.conf" >> "$KITTY_CONF"

echo "Продвинутые настройки успешно включены!"
echo "Перезапустите Kitty для применения изменений"
echo ""
echo "Чтобы отключить продвинутые настройки, удалите строку 'include advanced.conf' из kitty.conf"