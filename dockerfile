# Use an official Python slim runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies: cron for scheduling and git to clone the repo
RUN apt-get update && apt-get install -y cron git && rm -rf /var/lib/apt/lists/*

# Clone the repository from GitHub into the working directory
#RUN git clone https://github.com/IncubusVictim/HDHomeRunEPG-to-XmlTv.git .
RUN git clone https://github.com/melbatoast-net/HDHomeRunEPG-to-XmlTv.git .

RUN pip install --no-cache-dir requests argparse tzlocal pytz

# Copy the run script and the entrypoint script into the container's root
COPY run.sh entrypoint.sh /
# Make the scripts executable
RUN chmod +x /run.sh /entrypoint.sh

# Set default environment variables.
# CRON_SCHEDULE defaults to running at midnight every day.
ENV CRON_SCHEDULE="0 0 * * *"
# HDHOMERUN_IP must be changed by the user during 'docker run'.
ENV HDHOMERUN_IP="CHANGEME"
# OUTPUT_FILE is the path inside the container where the XMLTV file will be saved.
ENV OUTPUT_FILE="/data/guide.xml"

# Create the log file and the data directory for the output
RUN mkdir -p /var/log && touch /var/log/cron.log && mkdir -p /data
# Create the log file and the data directory for the output
#RUN touch /var/log/cron.log && mkdir -p /data

# Set the entrypoint to our custom script

ENTRYPOINT ["/entrypoint.sh"]

