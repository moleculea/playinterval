#!/bin/bash
seconds=0.0
minutes=0.0
frames=0.0
framerate=30.0
args=
filename="${@:(-1)}"
while (( "$#" )); do
if [ "$1" = "-seconds" ]
	then
	seconds="$2"
	shift 2
	args="$@"
fi
if [ "$1" = "-minutes" ]
	then
	minutes="$2"
	shift 2
	args="$@"
fi
shift
done
framerate=$(ffmpeg -i $filename 2>&1 | sed -n 's/.*, \(.*\) tbr.*/\1/p')
seconds=$(echo "scale=2; $seconds*$framerate"| bc)
minutes=$(echo "scale=2; $minutes*$framerate*60"| bc)
frames=$(echo "$seconds+$minutes"| bc)
frames=$(echo "($frames+0.5)/1" | bc)
mplayer -frames "$frames" $args


