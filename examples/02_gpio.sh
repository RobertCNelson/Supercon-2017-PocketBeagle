#!/bin/bash

echo "GPIO59: config-pin P2_02 in"
config-pin -q P2_02
sleep 1
echo "GPIO59: config-pin -q P2_02"
sleep 1
echo "GPIO59: config-pin -l P2_02"
config-pin -l P2_02
sleep 1
echo "GPIO59: config-pin P2_02 gpio_pu"
config-pin P2_02 gpio_pu
sleep 5
echo "GPIO59: config-pin P2_02 gpio_pd"
config-pin P2_02 gpio_pd
