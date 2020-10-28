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
| dns\_a\_record\_name | The host name | `string` | `"test"` | no |
| dns\_zone | The host name | `string` | `"icap-devops-test.co.uk"` | no |
| list\_of\_load\_balancer\_ips | The list of ips for the load balancers | `list(string)` | n/a | yes |
| location | The region | `string` | `"ukwest"` | no |
| resource\_group\_name | The resource group name | `string` | `"gw-icap-dns"` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_record\_set | n/a |

