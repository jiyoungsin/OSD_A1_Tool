if [[ $1 == 200 ]]
then 
    printf "${GREEN}Good Link ${NC}\n"
elif [[ $1 == 400 ]]
then
    exitCode=1
    printf "${RED}Bad Link ${NC}\n"
elif [[ $1 == 404 ]]
then
    exitCode=1
    printf "${RED}Bad Link ${NC}\n"
else
    exitCode=1
    printf "${GREY}Unknown ${NC}\n"
fi