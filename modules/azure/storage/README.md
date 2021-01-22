## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.30.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_replication\_type | The storage account replication type | `string` | n/a | yes |
| account\_tier | The storage account tier | `string` | n/a | yes |
| location | The Azure Location | `string` | n/a | yes |
| resource\_group\_name | The resource group name | `string` | n/a | yes |
| storage\_account\_name | The storage account name | `string` | n/a | yes |
| storage\_container\_name | The storage container name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| storage\_access\_key | n/a |
| storage\_account\_name | n/a |
| storage\_container\_name | n/a |
| storage\_resource\_group | n/a |

