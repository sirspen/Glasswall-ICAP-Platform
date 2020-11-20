provider "rancher2" {
  alias = "admin"
  api_url = var.rancher_admin_url
  token_key = var.rancher_admin_token
  insecure = true
}

resource "rancher2_catalog" "catalogue" {
  name       = "catalogue"
  url        = var.helm_charts_repo_url
  branch     = var.helm_charts_repo_branch
}

//resource "rancher2_catalog_v2" "cataloguev2" {
//  cluster_id  = var.cluster_id
//  name        = "cataloguev2"
//  git_repo    = var.helm_charts_repo_url
//  git_branch  = var.helm_charts_repo_branch
//}