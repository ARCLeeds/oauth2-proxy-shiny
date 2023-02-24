# Streamlit OAuth2-proxy and Azure

This directory contains codes for deploying a template streamlit app to Azure.

## Deploy to Azure

When deploying to Azure follow the steps in the [deployment script](./deploy-azure.sh).

This will successfully deploy resources but these require additional configuration for enable the Azure app service app to pull from our private Azure container registry.

To do this we need to set some **Application settings** for our Azure Web App, you can do this in the Azure portal or via the Azure CLI.

### Via the Portal

Navigate to your Web App in the Azure portal and select the Configuration option from the left hand menu under the **Settings** heading.

Here you can see **Application settings**, select New application setting and add the following settings:
- Name: DOCKER_REGISTRY_SERVER_PASSWORD, Value: A password value you can find in the Azure portal page for your container registry under the **Access keys** menu under the Settings heading
- Name: DOCKER_REGISTRY_SERVER_USERNAME, Value: the name of our Azure container registry (ACR_NAME from [deploy-azure.sh](./deploy-azure.sh))
- Name: DOCKER_REGISTRY_SERVER_URL, Value: the name of your Azure container registry plus .azurecr.io e.g. `authstreamlit.azurecr.io`

Set all these options as **Deployment slot settings** to ensure they're used in deployment. 

Restart your app to ensure these changes take effect.

### Via the `az` CLI

You can configure Azure web app settings from the CLI with the command:

```bash
az webapp config appsettings set -g MyResourceGroup -n MyAppName --settings \
    DOCKER_REGISTRY_SERVER_PASSWORD=PASSWORD \
    DOCKER_REGISTRY_SERVER_USERNAME=$ACR_NAME \
    DOCKER_REGISTRY_SERVER_URL=$ACR_NAME.azurecr.io
```

az webapp config appsettings set -g uol_it_rc_tempApp -n authstreamlit --settings \
    DOCKER_REGISTRY_SERVER_PASSWORD=57woapIgHcrvBCf/7KI2T22YGhn2Qf50JFHukWChDW+ACRANsGkW \
    DOCKER_REGISTRY_SERVER_USERNAME=$ACR_NAME \
    DOCKER_REGISTRY_SERVER_URL=$ACR_NAME.azurecr.io

## Email whitelist setup

Todo

## OAuth via GitHub gotchas

Todo