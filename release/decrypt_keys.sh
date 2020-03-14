#!/usr/bin/env bash
set -e

ENCRYPTION_KEY="$1"

if [[ ! -z "${ENCRYPTION_KEY}" ]]
then
    openssl enc -d -aes-256-cbc -md sha256 -in android/release.aes -out android/keyStore.jks -k "${ENCRYPTION_KEY}"
    openssl enc -d -aes-256-cbc -md sha256 -in android/properties.aes -out android/key.properties -k "${ENCRYPTION_KEY}"
    openssl enc -d -aes-256-cbc -md sha256 -in android/service.aes -out android/service_account.json -k "${ENCRYPTION_KEY}"
else
    echo "ENCRYPTION_KEY is missing"
fi
