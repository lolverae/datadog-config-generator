# Powershell Datadog config generator 

This project contains two scripts for configuring and managing Datadog configurations with yq.

## Script 1: Configure Datadog YAML

This script generates a Datadog YAML configuration file based on provided parameters.

### Parameters:
- `$AssetID`: The ID of the asset.
- `$ServerType`: Type of the server.
- `$TeamName`: Name of the team.
- `$EnvType`: Type of environment (e.g., NonProd).
- `$EnvironmentName`: Name of the environment.
- `$Region`: Region information.
- `$Hostname`: Hostname of the server.

### Usage:
- Modify the script with appropriate parameters.
- Execute the script to generate the Datadog YAML configuration file.

## Install yq

This script checks if Chocolatey is installed. If not, it installs yq using a custom function to download the executable file. If Chocolatey is already installed, it directly installs yq.


