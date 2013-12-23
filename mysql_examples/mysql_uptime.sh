#!/bin/sh
#mysql_uptime.sh - report server uptime in seconds

mysql --skip-column-names -B -e "show /*!50002 global */ status like 'Uptime'"
