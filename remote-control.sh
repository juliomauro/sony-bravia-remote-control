#!/bin/bash

TV="bravia.oruam.cloud"
PSK="CHANGE IN LINES 66 and 74"

# COMMANDS

POWERON(){
    SYSTEM="system"
    data="{\"method\":\"setPowerStatus\",\"version\":\"1.0\",\"id\":1,\"params\":[{\"status\":true}]}"
        command    
}

POWEROFF(){
    SYSTEM="system"
    data="{\"method\":\"setPowerStatus\",\"version\":\"1.0\",\"id\":1,\"params\":[{\"status\":false}]}"
        command    
}

VOLUME_UP(){
    SYSTEM="audio"
    data="{\"method\":\"setAudioVolume\",\"version\":\"1.0\",\"id\":1,\"params\":[{\"target\":\"speaker\",\"volume\":\"+1\"}]}"
        command
}

VOLUME_DOWN(){
    SYSTEM="audio"
    data="{\"method\":\"setAudioVolume\",\"version\":\"1.0\",\"id\":1,\"params\":[{\"target\":\"speaker\",\"volume\":\"-1\"}]}"
        command
}

MUTE(){
    SYSTEM="audio"
    data="{\"method\":\"setAudioMute\",\"version\":\"1.0\",\"id\":1,\"params\":[{\"status\":true}]}"
        command
}
UNMUTE(){
    SYSTEM="audio"
    data="{\"method\":\"setAudioMute\",\"version\":\"1.0\",\"id\":1,\"params\":[{\"status\":false}]}"
        command
}

MI(){
    SYSTEM="avContent"
    data="{\"method\":\"setPlayContent\",\"version\":\"1.0\",\"id\":1,\"params\":[{\"uri\":\"extInput:hdmi?port=2\"}]}"
        command
}

CHANNEL_UP(){
    BUTTON="AAAAAQAAAAEAAAAQAw"
    commandIR
}
CHANNEL_DOWN(){
    BUTTON="AAAAAQAAAAEAAAARAw"
    commandIR
}

DTV(){
    BUTTON="AAAAAgAAAHcAAAANAw"
    commandIR
}

command(){
curl http://$TV/sony/$SYSTEM \
    -H 'Origin: null' \
    -H 'X-Auth-PSK: juliomauro' \
    --data-binary ''$data'' \
    --compressed
}

commandIR(){
curl -H "Content-Type: application/json" \
  -X POST \
  -H "X-Auth-PSK: juliomauro" \
  -d '<?xml version="1.0" encoding="utf-8"?>
  <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  <s:Body>
      <u:X_SendIRCC xmlns:u="urn:schemas-sony-com:service:IRCC:1">
          <IRCCCode>'$BUTTON'</IRCCCode>
      </u:X_SendIRCC>
  </s:Body>
  </s:Envelope>' \
  http://$TV/sony/IRCC
}

show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " SONY BRAVIA REMOTE CONTROL"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1.  POWER ON"
    echo "2.  POWER OFF"
	echo "3.  VOLUME UP"
	echo "4.  VOLUME DOWN"
    echo "5.  CHANNEL UP"
    echo "6.  CHANNEL DOWN"
    echo "7.  UNMUTE"
    echo "8.  MUTE"
    echo "9.  DIGITAL TV"
    echo "10. MI BOX"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Enter choice: " choice
	case $choice in
		1) POWERON ;;
        2) POWEROFF ;;
		3) VOLUME_UP ;;
		4) VOLUME_DOWN ;;
        5) CHANNEL_UP ;;
        6) CHANNEL_DOWN ;;
        7) UNMUTE ;;
        8) MUTE ;;
        9) DTV ;;
        10) MI ;;
        0) exit 0 ;;
		*) exit 0
	esac
}

while true
do
 
	show_menus
	read_options
done