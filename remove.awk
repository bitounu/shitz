BEGIN { 
	FS=" " 
} 
{ 
	for (i=1; i <= NF; i++) 
		used[$i] = 1
	for (x in used)
		printf x, " %s "
	printf "\n"
	split("", used)
}
