#!/usr/bin/env bash

source ./_env.sh
source ./_clean-log.sh

UNSEAL_INFO_FILE="init-info.txt"
GEN_TOKEN_INFO_FILE="gen-token-info.json"
GENERATED_ROOT_TOKEN_FILE="generated-root-token.txt"

vault operator generate-root -init -format=json > $GEN_TOKEN_INFO_FILE

nonce=$(cat $GEN_TOKEN_INFO_FILE | jq -r '.nonce')
opt=$(cat $GEN_TOKEN_INFO_FILE | jq -r '.otp')
unseal_key=$(cat $UNSEAL_INFO_FILE | grep '^Unseal Key:' | awk '{ print $3 }')

encoded_root_token=$(vault operator generate-root -nonce=$nonce -format=json $unseal_key | jq -r '.encoded_root_token')

vault operator generate-root -otp=$opt -decode=$encoded_root_token > $GENERATED_ROOT_TOKEN_FILE

cat $GENERATED_ROOT_TOKEN_FILE