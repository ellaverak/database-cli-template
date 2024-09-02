# Database CLI template

This repo can be used as a template for setting up a database CLI tool for your own team.
We assume that your team uses University's openshift to run your service and University's DB server
for your postgres database instances.

Below is a step-by-step guide on how to set up db-tools deployment in your Openshift cluster
and how to use the current template repo to enable your team to connect to the staging and/or
production database.

## Setup

1. Create a deployment in your namespace called `db-tools`. Use `quay.io/toska/db-tools:latest` as an image for the deployment. You can follow your own usual way of creating a deployment.
2. Fork this repo
3. In `cli.sh` file, replace `<YOUR_OPENSHIFT_CLUSTER_URL_HERE>` placeholder with your openshift cluster URL. E.g. something like `https://api.ocp-prod-0.k8s.it.helsinki.fi:6443`
4. In `databases.txt`, you'll need to create a "key-value mapping" from the name of your database (this can be any word you want to name your DB) to the connection string of the database.
5. Finally, you'll need to get an authentication token for your openshift cluster and place it to the `production-token` file. The token is to be used in `cli.sh` as part of `oc login --server=$OPENSHIFT_URL --token=$API_TOKEN` command. You can access the token at `https://oauth-openshift.apps.<your-cluster-url>/oauth/token/request` e.g. `https://oauth-openshift.apps.ocp-prod-0.k8s.it.helsinki.fi/oauth/token/request`.
6. Now you can connect to your DB by running `./cli.sh` locally. Once executed, the script should automatically log you in your openshift server. It will then ask you to type in your database name. Use the name you specified in the `databases.txt` file. Enter the DB name and press enter. You should now be connected to the specified database!
