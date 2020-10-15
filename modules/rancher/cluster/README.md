## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| rancher2.admin | 1.10.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Bootstrap the virtual machine with this file | `string` | n/a | yes |
| cluster\_network\_plugin | Set the network plugin | `string` | `"canal"` | no |
| kubernetes\_version | The Kubernetes version | `string` | `"1.18.9"` | no |
| rancher\_admin\_token | The Rancher Admin Token | `string` | `"Standard_D2s_v3"` | no |
| rancher\_admin\_url | The Rancher API | `string` | `"RedHat:RHEL:7-LVM:latest"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kubernetes\_version | n/a |
| name | n/a |
| resource\_group | n/a |

