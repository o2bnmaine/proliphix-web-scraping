#!/bin/bash

cd /home/pi/automation/thermostats/logs/
rm /home/pi/automation/thermostats/logs/*

#program will update variables on a universal-devices.com ISY994. 
#logic has been created in the ISY994 that will act on improper temperature values

#possible grep values are rs1temp, rs2temp, localtemp. these will vary by thermostat model
#it is easy to find the proper values by inspecting the HTML generated when you open a thermostat webpage
#a smarter unix programmer will probably be able to shorten my sed/cut commands to reduce the complexity.
#I didn't bother finding a more efficient command string as it wouldn't really be more effective than what I found to work.

wget http://{uid}:{pwd}@{isy994_ipaddress}/rest/vars/set/2/{var_num}/$(curl --connect-timeout 5 http://{tstat_ipaddress} | grep rs1temp   | grep -v span | sed s/[\ \=a-z0-9]*// | sed s/\"// | sed s/\"// | cut -d "." -f1)

