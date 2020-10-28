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
| location | The Azure Location | `string` | `"UK West"` | no |
| network\_interface\_id | The network interface id to associate with the lb backend pool | `string` | n/a | yes |
| resource\_group\_name | The resource group name | `string` | `"gw-icap-load-balancer"` | no |

## Outputs

| Name | Description |
|------|-------------|
| load\_balancer\_name | n/a |

