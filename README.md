# Azure Modularized Terraform Project

This project uses Terraform to deploy an Azure Virtual Machine Scale Set (VMSS) behind a Standard Internal Load Balancer, using custom modules.

## Key Features

- Modular design for VMSS and Load Balancer.
- Dynamic environment/app naming.
- Security group rules set up per app type and environment.
- Supports custom override to enable/disable cluster-wide resources.

## Usage

1. Edit variables to suit your environment/app.
2. Make sure modules used under `source` are present.
3. Run the usual Terraform workflow: