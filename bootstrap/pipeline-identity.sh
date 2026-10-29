#!/usr/bin/env bash

# Don't run this script twice, only to be used once

set -euo pipefail

RG=tfstate
SA=tfstate7920
APP_ID=$(az ad app list --display-name "github-cloud-resume" --query "[].appId" -o tsv)
ROLE_ID=$(az role definition list --name "Storage Blob Data Contributor" --query "[].name" -o tsv)
CONDITION="((!(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})) OR (@Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAnyValues:GuidEquals {$ROLE_ID})) AND ((!(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})) OR (@Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAnyValues:GuidEquals {$ROLE_ID}))"

SP=$(az ad sp show --id "$APP_ID" --query id  -o tsv)

SA_ID=$(az storage account show --name "$SA" --resource-group "$RG" --query id -o tsv)

SUB_ID=$(az account show --query id -o tsv)

az role assignment create --assignee-object-id "$SP" --assignee-principal-type ServicePrincipal --role "Storage Blob Data Contributor" --scope "$SA_ID"

az role assignment create --assignee-object-id "$SP" --assignee-principal-type ServicePrincipal --role "Contributor" --scope "/subscriptions/$SUB_ID"

az role assignment create --assignee-object-id "$SP" --assignee-principal-type ServicePrincipal --role "Role Based Access Control Administrator" --scope "/subscriptions/$SUB_ID" --condition "$CONDITION" --condition-version "2.0"