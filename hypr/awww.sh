#!/bin/bash

BASE_DIR="$HOME/wallpapers"
STATE_DIR="$HOME/.cache/tema_selector"

# 1. Leer el tema
TEMA=$(cat "$STATE_DIR/current_theme" 2>/dev/null || echo "nature")
WALL_DIR="$BASE_DIR/$TEMA"
STATE_FILE="$STATE_DIR/last_$TEMA"

# 2. Buscar fondos
mapfile -t WALLS < <(find "$WALL_DIR" -type f | sort)
TOTAL_WALLS=${#WALLS[@]}

# 3. Elegir fondo
INDEX=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
# Si el índice es mayor que el total de fotos (por si borraste alguna), resetear a 0
if [ "$INDEX" -ge "$TOTAL_WALLS" ]; then INDEX=0; fi

WALLPAPER="${WALLS[$INDEX]}"

# 4. Aplicar (¡Aquí está la acción!)
awww img "$WALLPAPER" --transition-type grow --transition-pos top-right --transition-duration 2 &
wal -i "$WALLPAPER" -q

# 5. Guardar el SIGUIENTE índice para cuando pulses SUPER+W
NEXT=$(( (INDEX + 1) % TOTAL_WALLS ))
echo "$NEXT" > "$STATE_FILE"

# 6. Refrescar Waybar de forma agresiva
killall waybar
sleep 0.1
waybar &
