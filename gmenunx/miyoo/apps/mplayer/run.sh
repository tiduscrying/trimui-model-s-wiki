#!/bin/sh
RESUME=$(dirname "$1")/.$(basename "$1").resume

if [ -f "$RESUME" ]; then
	END=$(cat -v "$RESUME" | tail -3 | head -1 | sed 's/.*\ V://' | cut -dA -f1 | xargs) 
	./mplayer -ss $END -ao alsa -vo sdl -vf scale -zoom -xy 320 -screenw 320 -screenh 240 "$1" | tee "$RESUME"
else
	./mplayer -ao alsa -vo sdl -vf scale -zoom -xy 320 -screenw 320 -screenh 240 "$1" | tee "$RESUME"
fi

EXIT=$(tail -n 1 "$RESUME")

if [ "$EXIT" == "Exiting... (Quit)" ]; then
	#echo "Quit"

elif [ "$EXIT" == "Exiting... (End of file)" ]; then
	#echo "End"
	rm "$RESUME"
fi
