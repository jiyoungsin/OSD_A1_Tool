# Parsing file and looking for all URLS.
for i in $(grep -Eo '(http|https)://[^/"]+' $1)
do
	# user functionality.
	if [ "$2" = "-u" ]
	then
		curl $i -Im 3 -A "$3" -o headers -s &
	fi

	# Ignore and skip any URLs that start with urls from list
	source ignore_and_skip.sh
	# checking if the flag has been risen
	source check_flag.sh $flag

	# Saving the curl
	headers="$(curl $i -Im 1 -s &)"

	# Parse the status Code
	statusCode="$(echo $headers | cut '-d ' '-f2')"

	# Print URL and status Code
	
    printf "$i : $statusCode "
   
	# if the user would like json append text.
	if [[ $json -eq 0 ]]
	then
		jsonfile="$jsonfile{ \"url\": \"$i\", \"status\": $statusCode },"
	fi

	# Time buffer for curl. Improves accuracy.
	sleep 0.01

	# Enable colored code by turning variable CLICOLOR to 1
	if [[ $CLICOLOR -eq 0 ]]
	then
		RED='\033[0m'
		GREY='\033[0m'
		GREEN='\033[0m'
	fi

	# Printing of program Exit code
	source get_status_code_output.sh $statusCode
done
