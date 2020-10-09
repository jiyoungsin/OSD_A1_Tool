#!/bin/bash

# Colors for UI
RED='\033[0;31m' 
GREY='\033[0;37m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
CLICOLOR=1
exitCode=0
json=0

#### Help
Help()
{
	echo
	echo "Usage: cliCommand.sh [OPTION]... [FILE]"
	echo "Command-line tool to consider if urls are good, bad, or unknown."
	echo
	echo "  -v, --version    Print cliCommand version"
	echo "  -j, --json       Output results to urls.json file"
	echo "  -h, --help       Print this help message"
	echo
}


# Call getopt to validate the provided input. 
options=$(getopt -o vj:h --long version,json:,help -- "$@" 2> /dev/null)
[ $? -eq 0 ] || { 
    case "$1" in 
    # Output if json option is used incorrectly
    -j | --json )
        echo "Incorrect Usage: cliCommand.sh -j|--json [FILE]"
	exit 1
	;;
    *)
    	echo "Incorrect options provided"
    	Help
    	exit 1
	;;
    esac
}
eval set -- "$options"
while true; do
    case "$1" in
    # If the user wants to know the version
    -v | --version )
        source get_version.sh
	exit 0
        ;;
    # If the user wants a json output
    -j | --json )
	jsonfile="["
	shift;
	[[ ! -r $1 ]] && {
		echo "Incorrect Usage: cliCommand.sh -j [FILE]" 
		exit 1
	}
	break
        ;;
    -h | --help )
	Help
	exit 0
	;;
    --)
        shift
        break
        ;;
    esac
    shift
done

# if the user forgot to include arguements.
[[ $# -eq 0 ]] && {
	source get_instructions.sh
	exit 1
}


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

if [ $json -eq 0 ]
	then
		jsonfile="$jsonfile]"
		printf "$jsonfile" | sed 's/\(.*\),/\1 /' > urls.json
fi

source get_exit_code.sh $exitCode
