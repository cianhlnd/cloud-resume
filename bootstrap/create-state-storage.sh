#!/usr/bin/env bash

# Don't run this script twice, only to be used once

set -euo pipefail

RG=tfstate
SA=tfstate7920
CONTAINER=tfstate
LOCATION=northeurope

ME=$(az ad signed-in-user show --query id -o tsv)

az group create --name "$RG" --location "$LOCATION"

az storage account create --resource-group "$RG" --name "$SA" --location "$LOCATION" --sku Standard_LRS --kind StorageV2 --min-tls-version TLS1_2 --allow-blob-public-access false

SA_ID=$(az storage account show --name "$SA" --resource-group "$RG" --query id -o tsv)

az role assignment create --assignee "$ME" --role "Storage Blob Data Contributor" --scope "$SA_ID"

az storage container-rm create --name "$CONTAINER" --resource-group "$RG" --storage-account "$SA" 

az lock create --name statelock --resource-group "$RG" --resource "$SA" --lock-type CanNotDelete --resource-type Microsoft.Storage/storageAccounts

az storage account blob-service-properties update --account-name "$SA" --enable-versioning true --enable-delete-retention true --delete-retention-days 7