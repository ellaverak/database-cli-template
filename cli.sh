#!/bin/bash

OPENSHIFT_URL="https://api.ocp-prod-0.k8s.it.helsinki.fi:6443" # e.g. https://api.ocp-prod-0.k8s.it.helsinki.fi:6443

API_TOKEN=$(cat production-token)

oc login --server=$OPENSHIFT_URL --token=$API_TOKEN

DEPLOYMENT_NAME="db-tools"

POD_NAME=$(oc get pods -l deployment=$DEPLOYMENT_NAME -o jsonpath='{.items[0].metadata.name}')

db_names=()
db_urls=()

while read line; do
  name=$(echo $line | cut -d ' ' -f 1)
  url=$(echo $line | cut -d ' ' -f 2)

  db_names+=($name)
  db_urls+=($url)
done < databases.txt

echo "Database to connect to:"
read -r database_name

database_url=""

for i in ${!db_names[@]}; do
  if [ "$database_name" == "${db_names[$i]}" ]; then
    database_url="${db_urls[$i]}"
    break
  fi
done

if [ -z "$database_url" ]; then
  echo "Database not found"
  exit 1
fi

echo "Connecting to $database_url"

oc exec -it $POD_NAME -- psql $database_url
