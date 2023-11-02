#!/usr/bin/env bash

source ./_env.sh

cat <<'EOF' | vault policy write audit -
path "sys/audit/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/audit"
{
  capabilities = ["read", "sudo"]
}
EOF

vault audit enable file file_path=./vault-audit.json  
