#!/usr/bin/env bash

dnd=$(swaync-client -D)

count=$(swaync-client -c)

if [[ "$dnd" == "true" ]] && [[ "$count" -ne 0 ]]; then
  icon=""
elif [[ "$dnd" == "true" ]]; then
  icon=""
elif [[ "$count" -ne 0 ]]; then
  icon=""
else
  icon=""
fi

echo "$icon  $count"
