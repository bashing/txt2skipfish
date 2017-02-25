#!/bin/bash
#txt2skipfish
#Convert a txt file in a dictionary compatible with Skipfish.
#This is usefull to use skipfish as discovery tool, because it is a 
#very verfast scanner.

INPUT="$1"
OUTPUT="$2"

function help(){
	echo "Using:"
	echo "./$0 file.txt wordlist.wl"
}

function convert(){

	cat $INPUT  | awk {'print "w 1 1 1 "$1'} > $OUTPUT
	linea=false 

	while [ "$linea" != "" ] ; do 
		linea=$(strace skipfish -W $OUTPUT -I httpwww -o tt http://error/  &>i ; cat i | grep line | awk -Fline {'print $2'} | sed -e "s/\.//"| tail -1) 
			if [ "$linea" != "" ] ; then  
				echo "error line :$linea removing" 
				sed -i ''"$linea"'d' 
			fi
	done
}

function main(){
	
	if [ "$OUTPUT" != "" ]; then
		echo "Working..."
		convert
		echo "Finished.Nice day to science."
	else
		help
	fi
}

##################### MAIN #################
main 

