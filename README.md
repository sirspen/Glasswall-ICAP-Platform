# Glasswall-ICAP-Platform

This repo is in the early stages of development, right now its helping to prototype rancher features and it will evolve to eventually provision all the dependencies necessary to serve ICAP.  

To read more about the Glasswall ICAP Platform. The technical design documentation is here;
[ICAP Design Documentation](https://glasswallsolutionsltd-my.sharepoint.com/:w:/g/personal/pgerard_glasswallsolutions_com/EQyNuHOGDFNDmxTS282TGDABEke9OmBAz7pb872LA3BgfA?e=BlmDkL)
Access is restricted.

## Modules

1. [Azure VM](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/modules/azure/vm)
2. [Azure Network](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/modules/azure/network)
3. [Azure Subnet](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/modules/azure/subnet)
4. [Azure Public IP](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/modules/azure/public_ip)
5. [Azure Resource Group](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/modules/azure/resource_group)
6. [Glasswall ICAP](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/modules/glasswall/icap)

# How To

1. Clone the repo, execute `terraform init` in the root of the directory. 
2. Execute `terraform plan` to view the resources that will be created. This is an opportunity to look at naming conventions etc. 
3. Execute `terraform apply`. 
4. Got to the https endpoint on the ip in the output. 

## Requirements

A new version of Terraform is required. 

```
terraform {
  required_version = ">= 0.12.6"
}
```

## Providers
- azurerm
- rancher

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| linux\_vm\_public\_ips | n/a |
| tls\_private\_key | n/a |