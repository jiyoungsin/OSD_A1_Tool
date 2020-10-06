#!/bin/bash

# Colors for UI

RED='\033[0;31m' 
GREY='\033[0;37m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
CLICOLOR=1

function get_color_output(){
	if [[ $1 == 200 ]]
	then 
		printf "${GREEN}Good Link ${NC}\n"
	elif [[ $1 == 400 ]]
	then
		printf "${RED}Bad Link ${NC}\n"
	elif [[ $1 == 404 ]]
	then
		printf "${RED}Bad Link ${NC}\n"
	else
		printf "${GREY}Unknown ${NC}\n"
	fi
}

function get_no_color_output(){
	if [[ $1 == 200 ]]
	then 
		echo "Good Link"
	elif [[ $1 == 400 ]]
	then
		echo "Bad Link"
	elif [[ $1 == 404 ]]
	then
		echo "Bad Link"
	else
		echo "Unknown"
	fi
}
# if the user forgot to include arguements.
if [ $# -eq 0 ]
  then
	printf "Please enter the html file\n"
	printf "Ex. ./cliCommand <theFile.txt>\n"
	exit
fi

# If the user wants to know the version
if [ $1 = "-v" ] || [ $1 = "--version" ]
  then
	printf "v0.1\n"
	exit
fi 

# keep track of the number of entries.
number=0

# Parsing file and looking for all URLS.

for i in $(grep -Eo '(http|https)://[^/"]+' $1)
  do
	let "number+=1"
	# Run curl in the background with a timeout of 3 seconds
	if [ "$2" = "-u" ]
	then 
		curl $i -Im 3 -A "$3" -o headers -s &
	fi	
	
	headers="$(curl $i -Im 3 -s &)"
	
	# Save the status Code
	statusCode="$(echo $headers | cut '-d ' '-f2')"
	
	# Print the status Code
	printf "$i : $statusCode "
	
	# Time buffer for curl. Improves accuracy.
	sleep 0.05

	# If the user wants color they can Make it Colourful.
	if [[ $CLICOLOR -eq 0 ]]
	then
		get_no_color_output $statusCode
	else
		get_color_output $statusCode
	fi
done

echo "$?"
