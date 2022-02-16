#!/bin/bash

cat event_history.csv | grep -i "serdar" | grep -i "TerminateInstances" | grep -Eo "i-[A-Za-z0-9]{17}" | sort | uniq > result.txt