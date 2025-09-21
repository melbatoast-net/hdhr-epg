#!/bin/sh

echo "---"
echo "Cron job started: $(date)"
#source /app/environment.sh

# Validate that the HDHOMERUN_IP has been set by the user
if [ "${HDHOMERUN_IP}" = "CHANGEME" ] || [ -z "${HDHOMERUN_IP}" ]; then
  echo "Error: HDHOMERUN_IP environment variable is not set."
  exit 1
fi

# Ensure the output directory exists before writing to it
mkdir -p "$(dirname "${OUTPUT_FILE}")"

# Execute the python script with the required arguments
echo "Executing: /usr/local/bin/python3 /app/HDHomeRunEPG_To_XmlTv.py --host ${HDHOMERUN_IP} --filename ${OUTPUT_FILE}"
/usr/local/bin/python3 /app/HDHomeRunEPG_To_XmlTv.py --host "${HDHOMERUN_IP}" --filename "${OUTPUT_FILE}"
echo "Execution finished with exit code $?"
echo "Cron job finished: $(date)"
echo "---"