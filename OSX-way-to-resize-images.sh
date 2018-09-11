#!/bin/sh

# Change HSIZE and VSIZE to your requirements
# and use it this way:
# for i in ./*.JPG ; do this_script.sh $i ; done


HSIZE=1024    	# target width
VSIZE=1024		# target height
GETWIDTH=`sips --getProperty pixelWidth "$1" | cut -s -d :  -f 2 -`     # find real width
GETHEIGHT=`sips --getProperty pixelHeight "$1" | cut -s -d :  -f 2 -`   # find real height

# echo "WIDTH = $GETWIDTH"
# echo "HEIGHT = $GETHEIGHT"
# if image is horizontal
if [ $GETWIDTH -gt $GETHEIGHT ] ; then
	echo "Resizing HORIZONTAL: $1 ..."
	sips --resampleWidth $HSIZE "$1" 2>&1>/dev/null
else
	echo "Resizing VERTICAL: $1 ..."
	sips --resampleWidth $VSIZE "$1" 2>&1>/dev/null
fi
    
