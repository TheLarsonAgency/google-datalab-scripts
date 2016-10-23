#!/bin/bash

# Default settings for this script. You can change these.
NETWORK="datalab-network"
MACHINE="n1-highmem-2"
MACHNAME="${USER}-datalab"

# Settings drawn from gcloud config
PROJECT="$(gcloud config list 2>/dev/null | grep project | awk '{print $3}')"
ZONE="$(gcloud config list 2>/dev/null | grep zone | awk '{print $3}')"


# Create the network if it doesn't exist
gcloud compute networks create "${NETWORK}" \
  --project "${PROJECT}" \
  --description "Network for Datalab servers"

# Allow for SSH access, if you haven't already
gcloud compute firewall-rules create ${NETWORK}-allow-ssh \
  --project "${PROJECT}" \
  --allow tcp:22 \
  --network "${NETWORK}" \
  --description "Allow SSH access"

# Copy the manifest locally
gsutil cp gs://cloud-datalab/server.yaml ./datalab-server.yaml

# Launch the Google Compute VM instance
gcloud compute instances create "${MACHNAME}" \
  --project "${PROJECT}" \
  --zone "${ZONE}" \
  --network "${NETWORK}" \
  --image-family "container-vm" \
  --image-project "google-containers" \
  --metadata "google-container-manifest=$(cat datalab-server.yaml)" \
  --machine-type "${MACHINE}" \
  --scopes "cloud-platform"


# Launch the local docker container
echo Waiting 30 seconds for VM instance to launch SSH service

count=0
while [ $count -lt 30 ]; do
  echo -n "."
  sleep 1
done
echo

echo Attempting to connect to VM over gcloud ssh
gcloud compute ssh --quiet \
  --project "${PROJECT}" \
  --zone "${ZONE}" \
  --ssh-flag="-N" \
  --ssh-flag="-L" \
  --ssh-flag="localhost:8081:localhost:8080" \
  "${USER}@${MACHNAME}"


read -r -p "Would you like to take down the VM that we created? [y/N] " response
[[ ${response,,} =~ ^(yes|y)$ ]] && \
    gcloud compute instances delete "${MACHNAME}" --zone "${ZONE}"


exit 0
