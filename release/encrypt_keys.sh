#!/usr/bin/env bash
set -e

ENCRYPTION_KEY="$1"

if [[ ! -z "${ENCRYPTION_KEY}" ]]
then
    openssl enc -aes-256-cbc -md sha256 -in android/keyStore.jks -out android/release.aes -k "${ENCRYPTION_KEY}"
    openssl enc -aes-256-cbc -md sha256 -in android/key.properties -out android/properties.aes -k "${ENCRYPTION_KEY}"
else
    echo "ENCRYPTION_KEY is missing"
fi