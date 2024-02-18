#!/bin/bash

TZ=$1

sketchybar --set $NAME label="$(TZ=$TZ date '+%H:%M')"
