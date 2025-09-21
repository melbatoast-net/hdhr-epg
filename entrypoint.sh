#!/bin/sh

# Add the cron job using the schedule from the environment variable
#echo "${CRON_SCHEDULE} /run.sh >> /var/log/cron.log 2>&1" | crontab -
echo "${CRON_SCHEDULE} HDHOMERUN_IP=\"$HDHOMERUN_IP\" OUTPUT_FILE=\"$OUTPUT_FILE\" /run.sh >> /var/log/cron.log 2>&1" | crontab -

# Start the cron daemon in the background
cron

# Tail the log file to keep the container running and to stream logs to 'docker logs'
tail -f /var/log/cron.log
