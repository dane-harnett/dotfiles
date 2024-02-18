#!/bin/bash

getcolor() {

    color_name=$1
    opacity=$2

    local o100=0xff
    local o75=0xbf
    local o50=0x80
    local o25=0x40
    local o10=0x1a
    local o0=0x00

    local blue=#82aaff
    local teal=#64ffda
    local cyan=#89ddff
    local grey=#3b4252
    local green=#c3e88d
    local yellow=#ffcb6b
    local red=#ff5370
    local black=#000000
    local white=#eeeeee

    case $opacity in
        75) local opacity=$o75 ;;
        50) local opacity=$o50 ;;
        25) local opacity=$o25 ;;
        10) local opacity=$o10 ;;
        0) local opacity=$o0 ;;
        *) local opacity=$o100 ;;
    esac

    case $color_name in
        blue) local color=$blue ;;
        teal) local color=$teal ;;
        cyan) local color=$cyan ;;
        grey) local color=$grey ;;
        green) local color=$green ;;
        yellow) local color=$yellow ;;
        red) local color=$red ;;
        black) local color=$black ;;
        white) local color=$white ;;
        *)
            echo "Invalid color name: $color_name" >&2
            return 1
            ;;
    esac

    echo $opacity${color:1}
}

# Test the function
# getcolor white 75


# Bar and item colors
export BAR_COLOR=$(getcolor black 100)
export BAR_BORDER_COLOR=$(getcolor black 50)
export HIGHLIGHT=$(getcolor teal)
export HIGHLIGHT_75=$(getcolor teal 75)
export HIGHLIGHT_50=$(getcolor teal 50)
export HIGHLIGHT_25=$(getcolor teal 25)
export HIGHLIGHT_10=$(getcolor teal 10)
export ICON_COLOR=$(getcolor white)
export ICON_COLOR_INACTIVE=$(getcolor white 50)
export LABEL_COLOR=$(getcolor white 75)
export POPUP_BACKGROUND_COLOR=$(getcolor black 25)
export POPUP_BORDER_COLOR=$(getcolor black 0)
export SHADOW_COLOR=$(getcolor black)
export TRANSPARENT=$(getcolor black 0)

# Color Palette
BLACK=0xff181926
WHITE=0xffcad3f5
RED=0xffed8796
GREEN=0xffa6da95
BLUE=0xff8aadf4
YELLOW=0xffeed49f
ORANGE=0xfff5a97f
MAGENTA=0xffc6a0f6
GREY=0xff939ab7
TRANSPARENT=0x00000000

