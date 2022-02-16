#!/bin/bash

grep "invalid user" auth.log | cut -d' ' -f8 | uniq -c > invalid_user.sh

# grep "Invalid user" auth.log | cut -d' ' -f8 | uniq -c > invalid_user.sh