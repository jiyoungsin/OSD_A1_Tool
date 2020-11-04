# OSD_A1_Tool
Creating a command-line tool to consider if urls are good, bad, or unknown.

# Introduction

My name is Paul, welcome to my Open Source Development Repo.

During the next 12 weeks I will be completeing a series of blog posts documenting my experience in the Open Source community. 
You can find my blog [here](https://osd600.blogspot.com/).

# Instructions

Command : ./cliCommand.sh [OPTION] [FILE]

NOTE: This project will need Bash installed on your machine. Mac OS has bash built in, however, Windows OS may need to install Bash.
# Init Release:

Url Checker V0.1


![OSDgif](https://user-images.githubusercontent.com/44411777/93946180-9171b200-fd06-11ea-90fe-06c34cbee5c5.gif)




Feel free to play with codes, if you have a crazy idea, then pull request :)

# Scope

Create a command-line tool in your chosen language.

# How It Works

Using the power of Linux's built in commands, such as, grep, curl and head we can request urls via command line interface. This information is then processed using the Head command along with some additional features.
We simply check the status code of each URL we requested and let the user know if there are any Broken ( 400 and 404 ) links are found.

BAD links will be printed in RED
Good links will be printed in GREEN
Unknown links will be printed in GREY


# Optional Features Include:

1. Option -h or --help will return the help page.
2. Option -j or --json will return the urls being checked in a json.
3. Option -v or --version will return the current version information.
4. option -i or --ignore the program will ignore the given urls.
4. Colored code. Enable colored code by turning variable CLICOLOR to 1 ( default )

# Coming soon!
Any ideas are welcome!
