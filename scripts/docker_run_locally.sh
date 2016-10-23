#!/bin/bash


# Settings drawn from gcloud config
PROJECT="$(gcloud config list 2>/dev/null | grep project | awk '{print $3}')"


docker run -it -p "127.0.0.1:8081:8080" -v "$(pwd):/content" \
  -e "PROJECT_ID=${PROJECT}" \
  gcr.io/cloud-datalab/datalab:local


exit 0
