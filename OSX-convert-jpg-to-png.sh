#!/bin/sh

# Use it this way:
# for i in ./*.JPG ; do this_script.sh $i ; done

NEWFORMAT="png"

OLDFORMAT=`sips --getProperty format "$1" | cut -s -d :  -f 2 -`

    echo "Converting $1 from $OLDFORMAT to $NEWFORMAT"
	sips --setProperty format $NEWFORMAT "$1" 2>&1>/dev/null
