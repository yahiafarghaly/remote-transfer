#!/bin/bash

# Author: Yahia Farghaly
# LISENCE: MIT
# Version 0.0

CONFIG_FILE_PATH="$HOME/.transfer.b.conf"
SERVER_USER_NAME=""
SERVER_IP=""


show_help()
{
	echo " "
	echo "3 args must be provided"
	echo "./transfer.b -[send/get] [file/directory path] [file/directory path]"
	echo "For sending file or directory"
	echo "./transfer.b -send <file/directory path to send from your machine> <directory path to send to server>"
	echo "For retrieving a file or directory"
	echo "./transfer.b -get <directory/file path to retrieve from server> <directory path to your machine>"
	echo " "
}

send()
{
  echo "Sending $1 to $2 " 
	rsync -avz -e 'ssh' $1 $SERVER_USER_NAME@$SERVER_IP:$2
  exit
}

retrieve()
{
  echo "Retrieving $1 to $2 "
	rsync -avz -e 'ssh' $SERVER_USER_NAME@$SERVER_IP:$1 $2
  exit
}



if [ ! -f $CONFIG_FILE_PATH ]; then
    echo "This is first time of your use, let's setup some configurations"
    touch $CONFIG_FILE_PATH
    echo -n "Enter your server user name: "
    read SERVER_USER_NAME
    echo -n "Enter your server IP: "
    read SERVER_IP
    echo "Your Username is $SERVER_USER_NAME and IP is $SERVER_IP"
    echo "$SERVER_USER_NAME:$SERVER_IP" > $CONFIG_FILE_PATH
    echo "Your configurations are saved. for future edit in $CONFIG_FILE_PATH "
    echo -n 'Would you like to add transfer.b to your shell commands?[y/n]'
    read request

	    if [ "$request" = "y" ] || [ "$request" = "Y" ]
	    then
		      cp $(pwd)/transfer.b ~/.transfer.b
		      echo 'alias transfer.b="~/.transfer.b" ' >> ~/.bashrc
	    fi
else
    SERVER_USER_NAME=$(cut $CONFIG_FILE_PATH -d: -f1)
    SERVER_IP=$(cut $CONFIG_FILE_PATH -d: -f2)
    echo "Username: $SERVER_USER_NAME , IP: $SERVER_IP"
fi

if [ "$#" -eq 3 ]
then
    case "$1" in
        "-send") send "$2" "$3"
            ;;
        "-get") retrieve "$2" "$3"
            ;;
    esac
    	echo "Undefined option, -send/get are only allowed"
else
	echo "Not enough arguments"
	show_help
	exit 1
fi
