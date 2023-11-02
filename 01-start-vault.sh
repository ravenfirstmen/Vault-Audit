#!/usr/bin/env bash

# run in dev mode. Redirect output. We need unseal key
 vault server -dev -dev-root-token-id=root -log-level=error 1>init-info.txt