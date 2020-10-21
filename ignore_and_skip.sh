for j in $theIgnoreFile
	do
	current_url_within_double_for_loop="$i"
	ignore_me_url_from_file_for_loop="$j"
	if [ $current_url_within_double_for_loop = $ignore_me_url_from_file_for_loop ]
	then
		# raising a flag for exit for outter loop
		flag=0
		continue
	fi
done
