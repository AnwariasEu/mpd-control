#!/bin/bash

SERVER="localhost";
PASSWORD="";

if [[ ! -z $1 ]];then
	SERVER=$1;
	if [[ ! -z $2 ]];then
		PASSWORD=$2"@";
	fi
fi

export MPD_HOST=$PASSWORD$SERVER;
mpc status;
