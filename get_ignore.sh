# If the user wants to ignore urls
if [ $1 = "-i" ] || [ $1 = "--ignore" ]
then
	source get_ignore_help.sh
	exit 0
fi