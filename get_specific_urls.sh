# user pick what type of output wants
if [[ $1 = "-all" ]]
then
	source get_urls_function.sh $2
	exit 0
elif [[ $1 = "-good" ]]
then
	source get_good_links.sh $2
	exit 0
elif [[ $1 = "-bad" ]]
then
	source get_bad_links.sh $2
	exit 0
fi
