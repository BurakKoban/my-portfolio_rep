#!/bin/bash

cat event_history.csv | grep -i 'Serdar' | grep 'TerminateInstances' > result.txt