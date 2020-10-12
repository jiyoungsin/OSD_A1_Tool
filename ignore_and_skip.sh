for j in $theIgnoreFile
	do
	url="$i"
	url2="$j"
	if [ $url = $url2 ]
	then
		# raising a flag for exit for outter loop
		flag=0
		continue
	fi
done
