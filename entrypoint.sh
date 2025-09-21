#!/bin/sh

echo "Checking for existing guide file at ${OUTPUT_FILE}..."
if [ ! -f "${OUTPUT_FILE}" ]; then
  echo "Guide file not found. Performing initial run..."
  /run.sh
else
  echo "Guide file already exists. Skipping initial run."
fi
# --- END NEW SECTION ---

# Set up the scheduled cron job.
echo "${CRON_SCHEDULE} HDHOMERUN_IP=\"$HDHOMERUN_IP\" OUTPUT_FILE=\"$OUTPUT_FILE\" /run.sh >> /var/log/cron.log 2>&1" | crontab -

# Start the cron daemon in the background.
cron

# Tail the log file to keep the container running and show output.
tail -f /var/log/cron.log