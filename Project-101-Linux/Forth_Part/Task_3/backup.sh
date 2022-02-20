#!/bin/bash

grep "invalid user" auth.log | cut -d' ' -f8 | uniq -c > invalid_user.sh

# grep "invalid user" auth.log | cut -d' ' -f9 | uniq -c >> invalid_user.sh

