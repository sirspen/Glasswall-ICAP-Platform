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
| azure\_region | Node Region | `string` | n/a | yes |
| cloud\_credentials\_id | the credential name | `string` | n/a | yes |
| cluster\_subnet\_name | Set the cluster subnet | `string` | n/a | yes |
| cluster\_subnet\_prefix | Set the cluster subnet cidr prefix | `string` | n/a | yes |
| cluster\_virtual\_machine\_net | Set the Virtual Network for the Cluster | `string` | n/a | yes |
| docker\_url | Docker Install Url | `string` | `"https://releases.rancher.com/install-docker/19.03.sh"` | no |
| node\_disk\_size | Total size of Disk | `string` | `"120"` | no |
| node\_image | The os image to use for the base linux | `string` | `"RedHat:RHEL:7-LVM:latest"` | no |
| node\_ports | Node Ports | `list(string)` | <pre>[<br>  "80/tcp",<br>  "443/tcp",<br>  "6443/tcp",<br>  "2376/tcp",<br>  "2379/tcp",<br>  "2380/tcp",<br>  "8472/udp",<br>  "4789/udp",<br>  "9796/tcp",<br>  "10256/tcp",<br>  "10250/tcp",<br>  "10251/tcp",<br>  "10252/tcp"<br>]</pre> | no |
| node\_storage\_type | Node Storage Type | `string` | `"Standard_LRS"` | no |
| node\_type | the server type to use for the node | `string` | `"Standard_D1_v2"` | no |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |
| resource\_group | Resource Group | `string` | n/a | yes |
| service\_name | The service this cluyster belongs to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |

