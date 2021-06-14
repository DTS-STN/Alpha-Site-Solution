#!/bin/bash

VARFILE=$1

echo "Loading in variables from varfile"
echo $VARFILE
export TG_VAR_FILE=$VARFILE
export subscription_name=$(cat $VARFILE | jq -r .subscription_name)
export terraform_sp_name=$subscription_name-$(cat $VARFILE | jq -r .application_name)-terraform-sp
export subscription_id=$(cat $VARFILE | jq -r .subscription_id)
export depot_resource_group=$(cat $VARFILE | jq -r .depot_resource_group)
export location=$(cat $VARFILE | jq -r .location)
export remote_state_storage_account_name=$(cat $VARFILE | jq -r .subscription_name)TFStorage
export tfstate_storage_rg=$(cat $VARFILE | jq -r .subscription_name)TFStateRG
export application_name=$(cat $VARFILE | jq -r .application_name)
echo $terraform_sp_name


echo "Setting account"
az account set --subscription $subscription_id

export AZURE_STORAGE_KEY=$(az storage account keys list -g $tfstate_storage_rg -n $remote_state_storage_account_name --query [0].value -o tsv)
az storage container create --account-name $remote_state_storage_account_name --name $application_name --auth-mode key

sed -i "s/%REMOTE_STATE_STORAGE_ACCOUNT_NAME%/$remote_state_storage_account_name/g" $VARFILE
sed -i "s/%TFSTATE_STORAGE_RG%/$tfstate_storage_rg/g" $VARFILE

echo "Done."
