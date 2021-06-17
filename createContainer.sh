#!/bin/bash

VARFILE=$1

echo "Loading in variables from varfile"
echo $VARFILE
export TG_VAR_FILE=$VARFILE
export subscription_id=$(cat $VARFILE | jq -r .subscription_id)
export application_name=$(cat $VARFILE | jq -r .application_name)
export remote_state_storage_account_name=$(cat $VARFILE | jq -r .remote_state_storage_account_name)
export tfstate_storage_rg=$(cat $VARFILE | jq -r .tfstate_storage_rg)
echo $terraform_sp_name

echo "Setting account"
az account set --subscription $subscription_id

echo "Creating Terraform Service Principal..."
#TODO GET SP CREDS FROM KEYVAULT
# export terraform_sp_pass=$(az ad sp create-for-rbac --name $terraform_sp_name --role Contributor | grep password | cut -c16-49)
# export terraform_sp_id=$(az ad sp list --display-name $terraform_sp_name --query [].appId -o tsv)
echo "Done."

# echo "Setting Terraform SP ID and Pass in VarFile"
# sed -i "s/%CLIENT_ID%/$terraform_sp_id/g" $VARFILE
# sed -i "s/%CLIENT_SECRET%/$terraform_sp_pass/g" $VARFILE
#echo "Done"
echo $remote_state_storage_account_name
echo "Creating remote tfstate container..."
export AZURE_STORAGE_KEY=$(az storage account keys list -g $tfstate_storage_rg -n $remote_state_storage_account_name --query [0].value -o tsv)
# az storage container create --account-name $remote_state_storage_account_name --name $application_name --auth-mode key

echo "Done."
