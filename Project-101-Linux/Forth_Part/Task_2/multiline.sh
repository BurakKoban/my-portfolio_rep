#!/bin/bash

MY_KEY=$(cat certificate.pem)
echo -e $MY_KEY > new.pem
# echo -e $(cat certificate.pem) > new.pem