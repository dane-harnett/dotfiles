#!/bin/bash

name="bne"
timezone="Australia/Brisbane"
icon_char="󰯯"

date=(
  icon.drawing=off
  label.font="$FONT:Semibold:12"
  label.padding_right=0
  y_offset=8
  width=0
  update_freq=60
  script="${PLUGIN_DIR}/date_tz.sh ${timezone}"
)

clock=(
  icon.drawing=off
  label.font="$FONT:Bold:14"
  label.padding_right=0
  y_offset=-4
  update_freq=10
  script="${PLUGIN_DIR}/time_tz.sh ${timezone}"
)

icon=(
  icon="${icon_char}"
  icon.font="$FONT:Heavy:24.0"
  icon.padding_right=0
  label.drawing=off
)

sketchybar                                      \
  --add item date_${name} right                 \
  --set date_${name} "${date[@]}"               \
  --add item clock_${name} right                \
  --set clock_${name} "${clock[@]}"             \
  --add item icon_${name} right                 \
  --set icon_${name} "${icon[@]}"               \

