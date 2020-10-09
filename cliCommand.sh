#!/bin/bash

# Colors for UI
RED='\033[0;31m' 
GREY='\033[0;37m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
CLICOLOR=1
exitCode=0
json=0

# Call getopt to validate the provided input. 
if [[ $# -eq 0 ]] 
then
    	source get_help.sh
    	exit 1
fi

function get_urls(){
	# Parsing file and looking for all URLS.
	for i in $(grep -Eo '(http|https)://[^/"]+' $1)
  	    do
        	let "number+=1"
        	if [ "$2" = "-u" ]
        	then
                	curl $i -Im 3 -A "$3" -o headers -s &
        	fi

        	headers="$(curl $i -Im 1 -s &)"

        	# Save the status Code
        	statusCode="$(echo $headers | cut '-d ' '-f2')"

        	# Print the status Code
        	printf "$i : $statusCode "

	        if [[ $json -eq 0 ]]
        	then
                	jsonfile="$jsonfile{ \"url\": \"$i\", \"status\": $statusCode },"
        	fi
        	# Time buffer for curl. Improves accuracy.
        	sleep 0.05

	        # Enable colored code by turning variable CLICOLOR to 1
       		if [[ $CLICOLOR -eq 0 ]]
        	then
                	RED='\033[0m'
                	GREY='\033[0m'
                	GREEN='\033[0m'
        	fi

        	source get_status_code_output.sh $statusCode
	done
}

# If the user wants to know the version
if [ $1 = "-v" ] || [ $1 = "--version" ]
then
        source get_version.sh
	exit 0
fi

# If the user wants a json output
if [ $1 = "-j" ] || [ $1 = "--json" ]
then
	jsonfile='['
	get_urls $2
	jsonfile="$jsonfile]"
        printf "$jsonfile" | sed 's/\(.*\),/\1 /' > urls.json
	source get_exit_code.sh $exitCode
	exit
fi

if [ $1 = "-h" ] || [ $1 = "--help" ]
then
	source get_help.sh
	exit 0
fi

# if the user forgot to include arguements.
if [ $# -eq 0 ]
then
	source get_instructions.sh
	exit 1
fi

get_urls $1

source get_exit_code.sh $exitCode
