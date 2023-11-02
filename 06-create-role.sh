#!/usr/bin/env bash

source ./_env.sh
source ./_clean-log.sh

APP_ROLE_NAME="admin-approle"
APP_ROLE_ROLE_NAME="admin"
APP_ROLE_POLICY_NAME="vault-$APP_ROLE_NAME-policy"

vault policy read $APP_ROLE_POLICY_NAME >/dev/null

if [ $? -ne 0 ];
then
vault policy write $APP_ROLE_POLICY_NAME - <<EOF 
path "*" {
   capabilities = [ "sudo", "create", "read", "update", "delete", "patch" ]
}
EOF

vault auth enable -path=$APP_ROLE_NAME approle 
vault write auth/$APP_ROLE_NAME/role/$APP_ROLE_ROLE_NAME policies=$APP_ROLE_POLICY_NAME
fi

role_id=$(vault read auth/$APP_ROLE_NAME/role/$APP_ROLE_ROLE_NAME/role-id -format=json | jq -r '.data.role_id')
secret_id=$(vault write -f auth/$APP_ROLE_NAME/role/$APP_ROLE_ROLE_NAME/secret-id -format=json | jq -r '.data.secret_id')

# test
#vault write auth/$APP_ROLE_NAME/login role_id=$role_id secret_id=$secret_id

cat > app-role-info.json <<EOF
{
    "path": "$APP_ROLE_NAME",
    "role_id": "$role_id",
    "secret_id": "$secret_id"
}
EOF