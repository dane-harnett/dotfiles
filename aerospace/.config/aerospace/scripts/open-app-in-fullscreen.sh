#!/bin/bash

osascript <<EOF
if application "$1" is running then
    tell application "$1" to activate
else
    tell application "$1" to launch
    tell application "$1" to activate
end if
EOF

sleep 0.1

aerospace fullscreen on
