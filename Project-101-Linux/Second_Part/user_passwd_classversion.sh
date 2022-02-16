#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ ${UID} -ne 0 ]]
then
  echo 'Please run this script with sudo privilege or as root user'
  exit 1
fi

# Get the username (login).
read -p "Please enter your username (login) to create : " USER_NAME

# Get the real name (contents for the description field).
read -p "Please enter your name : " COMMENT

# Get the password.
read -s -p "Please enter your password : " PASSWORD

# Create the account.
useradd -c ${COMMENT} -m ${USER_NAME} 
# Check to see if the useradd command succeeded.

if [[ ${?} -ne 0 ]]
  then 
  echo "This username is already exist. Please select a different username"
  exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

#Check to see if the passwd command succeeded.

if [[ ${?} -ne 0 ]]
then
  echo 'The password for the account could not be set'
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username'
echo ${USER_NAME}
echo
echo 'Password'
echo ${PASSWORD}






