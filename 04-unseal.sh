#!/usr/bin/env bash

source ./_env.sh

UNSEAL_INFO_FILE="init-info.txt"

function unseal_vault {
  
  unseal_key=$(cat $UNSEAL_INFO_FILE | grep '^Unseal Key:' | awk '{ print $3 }')
  
  vault operator unseal $unseal_key

  echo "Vault unsealed.... the unseal info IS in $UNSEAL_INFO_FILE file"  
} 

vault status 1>/dev/null

# TODO: change to /v1/sys/health?!
# 200 if initialized, unsealed, and active
# 429 if unsealed and standby
# 472 if disaster recovery mode replication secondary and active
# 473 if performance standby
# 501 if not initialized
# 503 if sealed

case $? in

  "0")
    echo "Already unsealed! move on... BTW: the unseal info SHOULD be in $UNSEAL_INFO_FILE file"
    ;;

  "1")
    echo "Some error in the vault instance... exiting unseal process!"
    exit 1
    ;;

  "2")
    unseal_vault
    ;;

  *)
    echo "What?! (response was: $?)"
    ;;
esac