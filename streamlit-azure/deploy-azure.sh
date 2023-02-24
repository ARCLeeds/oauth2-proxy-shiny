

ACR_NAME=authstreamlit
RES_GROUP=uol_it_rc_tempApp
APP_PLAN=streamlit-auth-plan
# login to azure
az login

# create a resource group
az group create --location uksouth --resource-group $RES_GROUP

# create app service plan for app
az appservice plan create -g $RES_GROUP -n $APP_PLAN --sku B1 --is-linux

# create container registry and enable admin
az acr create --resource-group $RES_GROUP --name $ACR_NAME --sku Basic --admin-enabled

# login to acr locally
az acr login --name $ACR_NAME

# build our local app
docker build . -t $ACR_NAME.azurecr.io/test-streamlit:latest

# use docker compose to push the container to the acr
docker-compose -f docker-compose-az.yaml push

# deploy the web app as a multicontainer app
az webapp create -g $RES_GROUP \
                 -p $APP_PLAN \
                 -n authstreamlit \
                 --multicontainer-config-type compose \
                 --multicontainer-config-file docker-compose-az.yaml

# set app for continuous deployment 
az webapp deployment container config --enable-cd true \
                                      --name authstreamlit \
                                      --resource-group $RES_GROUP