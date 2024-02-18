#!/bin/bash

# Load defined icons
source "$CONFIG_DIR/icons.sh"

# Load defined colors
source "$CONFIG_DIR/colors.sh"

PADDINGS=8
FONT="Hasklug Nerd Font Mono"
NERD_FONT="Hasklug Nerd Font Mono"

# Bar Appearance
bar=(
  color=$BAR_COLOR
  position=top
  topmost=off
  sticky=on
  height=44
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  corner_radius=0
  blur_radius=0
)

# Item Defaults
item_defaults=(
  background.color=$TRANSPARENT
  background.padding_left=$(($PADDINGS / 2))
  background.padding_right=$(($PADDINGS / 2))
  icon.padding_left=2
  icon.padding_right=$(($PADDINGS / 2))
  icon.background.corner_radius=4
  icon.background.height=18
  icon.font="$FONT:Regular:12"
  icon.color=$ICON_COLOR
  icon.highlight_color=$HIGHLIGHT
  label.font="$FONT:Regular:12"
  label.color=$LABEL_COLOR
  label.highlight_color=$HIGHLIGHT
  label.padding_left=$(($PADDINGS / 2))
  updates=when_shown
  scroll_texts=on
)

