resource "rancher2_catalog" "catalogue" {
  provider = rancher2
  name     = var.name
  url      = var.helm_charts_repo_url
  branch   = var.helm_charts_repo_branch
  version  = "helm_v3"
}