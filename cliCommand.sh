#!/bin/bash

# Setting Global Environmental Variables
source get_environmental_variables.sh

# if the user forgot to include arguements.
if [[ $# -eq 0 ]] 
then
	source get_help.sh
	exit 1
fi

# Checking users special options "--version" or "--help"
source get_information.sh $1
# Checking users special options "--json"
source get_json.sh $1
# Checking users special options "--ignore"

# source get_ignore.sh $1
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

source get_urls_function.sh $1
source get_exit_code.sh $exitCode
