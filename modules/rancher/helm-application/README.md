## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| rancher2 | 1.10.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| catalog\_name | The catalog name | `string` | n/a | yes |
| cluster\_endpoint\_csv | The list of cluster endpoints in csv | `string` | n/a | yes |
| create\_namespace | n/a | `bool` | n/a | yes |
| docker\_config\_json | The docker config json | `string` | n/a | yes |
| helm\_chart\_repo\_url | The git repo url | `string` | n/a | yes |
| namespace | Namespace | `string` | n/a | yes |
| project\_id | The project id | `string` | n/a | yes |
| system\_app | n/a | `bool` | n/a | yes |
| system\_id | The system project id | `string` | n/a | yes |
| template\_name | Helm template name | `string` | n/a | yes |

## Outputs

No output.

