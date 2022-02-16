#!/bin/bash
IP_ADDRESS=$(grep -i "PrivateIpAddress" info.json | head -n1 | cut -d'"' -f4)
sed -i "s/ec2-private_ip/$IP_ADDRESS/g" terraform.tf

# sed -i "s/ec2-private_ip/$(grep -i "PrivateIpAddress" info.json | head -n1 | cut -d'"' -f4)/g" terraform.tf