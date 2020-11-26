## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| rancher2 | 1.10.3 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_id | The Cluster ID | `string` | n/a | yes |
| node\_pool\_nodes\_qty | The total number of node pool nodes | `string` | n/a | yes |
| node\_pool\_role\_control\_plane | The total number of node pool nodes | `bool` | n/a | yes |
| node\_pool\_role\_etcd | Should the nodes use etcd? | `bool` | n/a | yes |
| node\_pool\_role\_worker | Should the nodes be used as workers ? | `bool` | n/a | yes |
| node\_pool\_template\_id | The Node Pool Template to use | `string` | n/a | yes |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |
| resource\_group | Resource Group | `string` | n/a | yes |
| service\_name | The Service Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |

