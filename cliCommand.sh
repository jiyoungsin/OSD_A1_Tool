#!/bin/bash

# Checking if branch working or not

# Setting Global Environmental Variables
source get_environmental_variables.sh

# if the user forgot to include arguements.
source get_help.sh $#

# Checking users special options "--version" or "--help"
source get_information.sh $1

# If the user wants a json output
if [ $1 = "-j" ] || [ $1 = "--json" ]
then
	jsonfile='['
	source get_urls_function.sh $2
	jsonfile="$jsonfile]"
	printf "$jsonfile" | sed 's/\(.*\),/\1 /' > urls.json
	source get_exit_code.sh $exitCode
	exit 0
fi

# Checking users special options "--ignore"
if [ $1 = "-i" ] || [ $1 = "--ignore" ] && [[ -f $2 ]] && [[ -f $3 ]]
then
	theIgnoreFile=$( cat $2 | grep -Eo '(http|https)://[^/"]+' )
	source get_urls_function.sh $3
	exit 0
elif [ $1 = "-i" ] || [ $1 = "--ignore" ]
then
	source get_ignore_help.sh
	exit 0
fi

# Default case
source get_urls_function.sh $1
source get_exit_code.sh $exitCode
