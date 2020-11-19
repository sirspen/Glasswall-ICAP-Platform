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
| access | Allow or Disallow | `string` | n/a | yes |
| destination\_port\_range | The destination port range | `string` | n/a | yes |
| direction | Inbound or Outbound | `string` | n/a | yes |
| network\_security\_group\_name | The network security group name | `string` | n/a | yes |
| priority | The level of the security group, priorities overide each other | `number` | n/a | yes |
| protocol | Tcp, Udp, Icmp, or \* | `string` | n/a | yes |
| resource\_group\_name | The resource group name | `string` | n/a | yes |
| service\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |
| source\_port\_range | The source port range | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |

