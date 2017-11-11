#!/bin/bash

cd /sys/class/gpio/gpio59/
echo "GPIO59: direction"
cat direction
sleep 1
echo "GPIO59: direction=out"
echo out > direction
sleep 1
echo "GPIO59: output high"
echo 1 > value
sleep 5
echo "GPIO59: output low"
echo 0 > value
