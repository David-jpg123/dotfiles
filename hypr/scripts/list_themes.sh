#!/bin/bash
ls -d $HOME/wallpapers/*/ 2>/dev/null | xargs -n 1 basename | jq -R . | jq -s .
