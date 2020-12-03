# Deploy ICAP Clusters 

The rancher bootstrap is required to be online and functional before you provision the rancher clusters. To begin provisioning infrastructure make sure you have all the prerequirements setup in the Azure cloud then; 

## Configure the setup

## Steps

1. Deploy Rancher Server with the rancher-bootstrap terraform module
    a. change to the `cd main/rancher-bootstrap`
    b. execute a `terraform plan`
    c. execute a `terraform apply`
2. Deploy the Clusters
    a. change to the `cd main/rancher-clusters`
    b. execute a `terraform plan`
    c. execute a `terraform apply`





