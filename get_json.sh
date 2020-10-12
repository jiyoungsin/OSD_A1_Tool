# If the user wants a json output
if [ $1 = "-j" ] || [ $1 = "--json" ]
then
	jsonfile='['
	get_urls $2
	jsonfile="$jsonfile]"
	printf "$jsonfile" | sed 's/\(.*\),/\1 /' > urls.json
	source get_exit_code.sh $exitCode
	exit 0
fi
