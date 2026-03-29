#!/bin/bash
# AUTHOR: Devilx
# Copyright © Devilx
# License: GNU General Public License v3.0
# Set your repo URL (or export DEVILX_REPO_URL) before using menu option (6) Update.
DEVILX_REPO_URL="${DEVILX_REPO_URL:-https://github.com/YOURUSERNAME/Devilx}"

GREEN=$(tput setaf 2)
LIGHTBLUE=$(tput setaf 6)
WHITE=$(tput setaf 15)

function check {
  attempts=5;
  Password=$(sed -nr "/^\[Settings\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" <Configuration/Configuration.ini)
  printf "${LIGHTBLUE}\nINSERT YOUR UPDATE PASSWORD YOU HAVE $attempts ATTEMPTS\n\n"
  while [[ $attempts>0 ]];
    do
      read -p "$GREEN[#NOTDEAD#]$WHITE-->" pass
      while [[ $pass == "" ]]
      do
        printf "${LIGHTBLUE}\nINSERT YOUR UPDATE PASSWORD YOU HAVE $attempts ATTEMPTS\n\n"
        read -p "$GREEN[#NOTDEAD#]$WHITE-->" pass
      done
      if [ "$pass" == "$Password" ];
        then
        printf "${LIGHTBLUE}\nPASSWORD CORRECT!\n"
        update
      fi
        ((attempts=attempts-1))
        printf "$LIGHTBLUE\nWRONG PASSWORD REMAINING: $attempts ATTEMPTS\n\n"
    done
    printf "${WHITE}\nYOU HAVE: $attempts PRESS ENTER TO EXIT"
    read -p
    exit 1
}


function update {
  Update_path=$(sed -nr "/^\[Settings\]/ { :l /^Path[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" <Configuration/Configuration.ini)
  cd $Update_path
  mv Devilx Devilx2  &>/dev/null
  git clone "$DEVILX_REPO_URL" &>/dev/null | printf "$WHITE\nUPDATING Devilx..\n"

  if [ $? -eq  0 ];
    then
    cd $Update_path
    printf "${WHITE}\nWOULD YOU LIKE TO DELETE THE OLD FILES?(1)YES(2)NO\n\n"
    read -p "$GREEN[#NOTDEAD#]$WHITE-->" conf
    if [ $conf = 1 ];
      then
      rm -r Devilx2 &>/dev/null | printf "${LIGHTBLUE}\nDELETING OLD Devilx FILES"
    else
      printf "${LIGHTBLUE}\nKEEPING OLD Devilx FILES"
    fi
    sleep 2
    printf "${WHITE}\n\nDevilx UPDATED CORRECTLY\n\n"
    read -p "$GREEN[#NOTDEAD#]$WHITE-->" confvar
    printf "${WHITE}\nPRESS ENTER TO EXIT"
    read -p
    exit 1

  fi
    printf "${LIGHTBLUE}\n\nDevilx NOT INSTALLED HAVE YOU CHECKED YOUR INTERNET CONNECTION?\n\n"
    mv Devilx2 Devilx
    exit 1
}
check
