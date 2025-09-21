#!/bin/bash

echo "---"
echo "Cron job started: $(date)"

# Validate that the HDHOMERUN_IP has been set by the user
if [ "${HDHOMERUN_IP}" = "CHANGEME" ] || [ -z "${HDHOMERUN_IP}" ]; then
  echo "Error: HDHOMERUN_IP environment variable is not set."
  exit 1
fi

# Ensure the output directory exists before writing to it
mkdir -p "$(dirname "${OUTPUT_FILE}")"

# Execute the python script with the required arguments
echo "Executing: python3 /app/HDHomeRunEPGtoXMLTV.py ${HDHOMERUN_IP} ${OUTPUT_FILE}"
python3 /app/HDHomeRunEPGtoXMLTV.py "${HDHOMERUN_IP}" "${OUTPUT_FILE}"
echo "Execution finished with exit code $?"
echo "Cron job finished: $(date)"
echo "---"