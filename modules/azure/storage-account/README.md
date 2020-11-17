## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.30.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_kind | The Storage Account kind | `string` | n/a | yes |
| account\_replication\_type | The Storage Account replication type | `string` | n/a | yes |
| account\_tier | The Storage Account tier | `string` | n/a | yes |
| azure\_region | The Azure Region | `string` | n/a | yes |
| resource\_group\_name | The Resource Group name | `string` | n/a | yes |
| service\_name | The Storage Account name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| primary\_access\_key | n/a |
| primary\_access\_region | n/a |
| secondary\_access\_key | n/a |
| secondary\_access\_region | n/a |
| storage\_account\_name | n/a |

