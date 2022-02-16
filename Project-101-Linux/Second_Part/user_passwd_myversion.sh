#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.


# Get the username (login).
read -p "Please enter your username (login) : " username

# Get the real name (contents for the description field).
read -p "Please enter your name : " personname

# Get the password.
read -s -p "Please enter your password : " password

# Create the account.
sudo useradd -m -c " Account of $personname" $username 
# Check to see if the useradd command succeeded.

if [[ $? -eq 0 ]]
  then 
  cat /etc/passwd | grep "$username"
  echo "$username has been created succesfully"
  sudo passwd $username
  echo "Your Username  : $username
      Your password : $password
      Your Host name : $(hostname)"
  else
  echo "$username has not been created. Please choose a different username and try again!!!"
fi






# We don't want to tell the user that an account was created when it hasn't been.

# Set the password.

# Check to see if the passwd command succeeded.

# Force password change on first login.

# Display the username, password, and the host where the user was created.

