if [[ $1 -eq 0 ]] 
then
    echo
    echo " ----------------------------------------------------------------- "
    echo "|                                                                 |"
    echo "| Usage: cliCommand.sh [OPTION]... [FILE]                         |"
    echo "| Command-line tool to consider if urls are good, bad, or unknown |"
    echo "|                                                                 |"
    echo "|    -h, --help       Print this help message                     |"
    echo "|    -v, --version    Print cliCommand version                    |"
    echo "|    -i, --ignore     Ignores list of urls in file                |"
    echo "|    -j, --json       Output results to urls.json file            |"
    echo "|                                                                 |"
    echo " ----------------------------------------------------------------- "
    echo
    exit 1
fi