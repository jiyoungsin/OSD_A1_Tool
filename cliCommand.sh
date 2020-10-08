#!/bin/bash

# Colors for UI
RED='\033[0;31m' 
GREY='\033[0;37m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
CLICOLOR=1
exitCode=0

# if the user forgot to include arguements.
if [ $# -eq 0 ]
  then
	source how_to_use
	exit
fi

# If the user wants to know the version
source get_version.sh $1

# Parsing file and looking for all URLS.
for i in $(grep -Eo '(http|https)://[^/"]+' $1)
  do
	let "number+=1"
	# Run curl in the background with a timeout of 3 seconds
	if [ "$2" = "-u" ]
	then 
		curl $i -Im 3 -A "$3" -o headers -s &
	fi	
	
	headers="$(curl $i -Im 1 -s &)"
	
	# Save the status Code
	statusCode="$(echo $headers | cut '-d ' '-f2')"
	
	# Print the status Code
	printf "$i : $statusCode "
	
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

source get_exit_code.sh $exitCode