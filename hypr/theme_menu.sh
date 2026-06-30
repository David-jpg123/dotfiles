#!/bin/bash

THEME_DIR="$HOME/.config/hypr/themes"
STATE_DIR="$HOME/.cache/tema_selector"
WAYBAR_DIR="$HOME/.config/waybar"

mkdir -p "$STATE_DIR"

OPCIONES=$(ls "$THEME_DIR" | sed 's/\.lua//')

TEMA_ELEGIDO=$(echo "$OPCIONES" | rofi -dmenu -p "Selecciona un tema" -theme-str 'window { width: 20%; } listview { lines: 8; }')

if [ -z "$TEMA_ELEGIDO" ]; then
    exit 0
fi

echo "$TEMA_ELEGIDO" > "$STATE_DIR/current_theme"

ln -sf "$THEME_DIR/$TEMA_ELEGIDO.lua" "$HOME/.config/hypr/current_theme.lua"
ln -sf "$WAYBAR_DIR/themes/$TEMA_ELEGIDO.jsonc" "$WAYBAR_DIR/config.jsonc"
ln -sf "$WAYBAR_DIR/themes/$TEMA_ELEGIDO.css" "$WAYBAR_DIR/style.css"

$HOME/.config/hypr/tu_script_de_wallpapers.sh

hyprctl reload
waybar &

bash $HOME/.config/hypr/awww.sh

echo "¡Ecosistema y caché actualizados a $TEMA_ELEGIDO!"
