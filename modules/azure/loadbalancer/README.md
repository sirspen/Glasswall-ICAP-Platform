## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | =2.30.0 |
| azurerm | ~> 2.30.0 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| azurerm | =2.30.0 ~> 2.30.0 |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | Metadata Azure Region | `string` | `"uksouth"` | no |
| environment | Metadata Environment | `string` | `"dev"` | no |
| organisation | Metadata Organisation | `string` | `"gw"` | no |
| project | Metadata Project | `string` | `"icap"` | no |
| subscription\_id | Subscription ID | `string` | `"b8177f86-515f-4bff-bd08-1b9535dbc31b"` | no |
| suffix | Metadata Suffix | `string` | `"p1"` | no |
| tenant\_id | Tenant ID | `string` | `"7049e6a3-141d-463a-836b-1ba40d3ff653"` | no |

## Outputs

No output.
