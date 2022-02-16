#!/bin/bash

# Check if we are root privilage or not
if [[ ${UID} -ne 0 ]]
then
  echo 'Please run this script with sudo privilege or as root user'
  exit 1
fi
# Which files are we going to back up. Please make sure to exist /home/ec2-user/data file
BACKUP_FILES="/home/ec2-user/data /etc /boot /usr"


# Where do we backup to. Please crete this file before execute this script
DESTINATION="/mnt/backup"

# Create archive filename based on time
TIME=$(date ="%Y_%m_%d_%I_%M_%p")
HOSTNAME=$(hostname -s)
ARCHIVE_FILE="${HOSTNAME}-${TIME}.tgz"


# Print start status message.
echo "We'll back up ${BACKUP_FILES} to ${DESTINATION}/${ARCHIVE_FILE}"


# Backup the files using tar.
tar czf ${DESTINATION}/${ARCHIVE_FILE} ${BACKUP_FILES}

# Print end status message.
echo "Congragulations! Your back up is ready"

# Long listing of files in $dest to check file sizes.
ls -lh ${DESTINATION}

# sudo tar -xzvf /mnt/backup/<your backup name> 
# sudo tar -xzvf /mnt/backup/ip-172-31-63-222-2022_02_16_02_42_AM.tgz -C /tmp etc/hosts