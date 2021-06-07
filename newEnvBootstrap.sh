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
export remote_state_storage_account_name=$(cat $VARFILE | jq -r .remote_state_storage_account_name)
export application_name=$(cat $VARFILE | jq -r .application_name)
echo $terraform_sp_name


echo "Setting account"
az account set --subscription $subscription_id

echo "Cleaning Workspace"
rm -rfd $(find . -name \*.terraform -type d)
rm  $(find . -name provider.tf -type f)
echo "Done."

echo "Creating Terraform Service Principal..."
export terraform_sp_pass=$(az ad sp create-for-rbac --name $terraform_sp_name --role Contributor | grep password | cut -c16-49)
export terraform_sp_id=$(az ad sp list --display-name $terraform_sp_name --query [].appId -o tsv)
echo "Done."

echo "Setting Terraform SP ID and Pass in VarFile"
sed -i "s/%CLIENT_ID%/$terraform_sp_id/g" $VARFILE
sed -i "s/%CLIENT_SECRET%/$terraform_sp_pass/g" $VARFILE
echo "Done"

echo "Waiting 30 seconds for SPs to Propogate"
sleep 30
echo "Done"

echo "Creating Resource Group..."
az group create --name $subscription_name$depot_resource_group --location $location 
echo "Done."
echo "Creating Storage Account..."
az storage account create \
    --name $remote_state_storage_account_name \
    --resource-group $depot_resource_group \
    --location $location \
    --sku Standard_RAGRS \
    --kind StorageV2
export AZURE_STORAGE_KEY=$(az storage account keys list -g $depot_resource_group -n $remote_state_storage_account_name --query [0].value -o tsv)
echo "Done."
echo "Creating TFState Container In Storage Account..."
az storage container create --account-name $remote_state_storage_account_name --name $application_name --auth-mode key
echo "Done."

echo "Importing Resource Group To Terraform..."
pushd ./resourceGroups
terragrunt import azurerm_resource_group.depot /subscriptions/$subscription_id/resourceGroups/$depot_resource_group
echo "Done."

echo "Creating Remaining Resource Groups..."
terragrunt apply --auto-approve 
popd
echo "Done."

echo "Importing Storage Account To Terraform..."
pushd ./infrastructure
terragrunt import azurerm_storage_account.depot-storageacct /subscriptions/$subscription_id/resourceGroups/$depot_resource_group/providers/Microsoft.Storage/storageAccounts/$remote_state_storage_account_name
echo "Done."