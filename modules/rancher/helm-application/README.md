## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| rancher2.adm | 1.10.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| catalogue\_name | The catalogue name | `string` | n/a | yes |
| namespace | Namespace | `string` | n/a | yes |
| project\_ids | A list of projects ids | `set(string)` | n/a | yes |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |
| template\_name | Helm template name | `string` | n/a | yes |

## Outputs

No output.

