#!/usr/bin/env bash

vault audit disable file
rm -rf ./vault-audit.json
vault audit enable file file_path=./vault-audit.json

