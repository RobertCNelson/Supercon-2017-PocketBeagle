#!/bin/bash

cd /sys/devices/platform/ocp/48302000.epwmss/48302200.pwm/pwm/pwmchip*/

echo "0 > export"
echo 0 > export
echo "20000 -> period"
echo 20000 > pwm-2\:0/period
echo "10000: -> duty_cycle"
echo 10000 > pwm-2\:0/duty_cycle
echo "1 -> enable"
echo 1 > pwm-2\:0/enable
