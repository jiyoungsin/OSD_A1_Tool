# If the user wants to know the version
if [ $1 = "-v" ] || [ $1 = "--version" ]
then
	echo "v0.2"
	exit 0
elif [ $1 = "-h" ] || [ $1 = "--help" ]
then
	source get_help.sh
	exit 0
fi