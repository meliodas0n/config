#!/usr/bin/bash

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar left -c $(dirname $0)/config.ini &

if [[ $(xrandr -q | grep 'HDMI-0 connected') ]]; then
	polybar right -c $(dirname $0)/config.ini &
fi

if [[ $(xrandr -q | grep 'DP-0 connected') ]]; then
	polybar main -c $(dirname $0)/config.ini &
fi 