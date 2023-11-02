#!/usr/bin/env bash

source ./_env.sh
source ./_clean-log.sh

APP_ROLE_NAME="admin-approle"
APP_ROLE_SECRETS_INFO="app-role-info.json"

role_id=$(cat $APP_ROLE_SECRETS_INFO | jq -r '.role_id')
secret_id=$(cat $APP_ROLE_SECRETS_INFO | jq -r '.secret_id')

vault write auth/$APP_ROLE_NAME/login role_id=$role_id secret_id=$secret_id
