#!/bin/sh
# mysql_uptime3.sh - report server uptime

echo status | mysql | grep "^Uptime"
