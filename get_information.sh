# If the user wants to know the version
if [ $1 = "-v" ] || [ $1 = "--version" ]
then
	source get_version.sh
	exit 0
fi

# If the user needs help
if [ $1 = "-h" ] || [ $1 = "--help" ]
then
	source get_help.sh
	exit 0
fi