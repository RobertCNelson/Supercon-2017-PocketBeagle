#!/bin/bash

echo "GPIO50: config-pin -q P2_01"
config-pin -q P2_01
sleep 1
echo "GPIO50: config-pin -l P2_01"
config-pin -l P2_01
