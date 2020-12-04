# Glasswall-ICAP-Platform

### The environment modules
This directory contains the terraform backend and modules that load in modules from the workspace. It provides a easy mechanism of organising a one to many terraform deployment pattern. Terraform modules typically store the backend in the module and this is a useful pattern but in a case of a developer at Glasswall you want to be able to prototype your terraform code before you use it in production. Using the modules in environments enables you to have a easy way to setup a new set of services by replicating a few modules and setting up a new backend. The format for the environments folder is `environments/branch/modules`. Where branch is the name of the branch you are currently on, the backend uses the branch to differentiate with other backends. There is one last benefit, using this method we can avoid having code conflicts between different branches when merging back to the main branch. 

### The workspace modules
This directory contains assembled terraform components which define a component in the final delivery infrastructure. Entities like the Rancher server, and the Clusters are assembled in the workspace as well as pre-prequisites like state storage, secrets management and a container registry.

1. [Rancher Bootstrap](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/workspace/rancher-bootstrap)
2. [Proto Multi Cluster](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/workspace/proto-multi-cluster)

### The modules directory is for reusable resource collections or single resource terraform modules 
This directory contains many module libraries and one meta module ('gw'). The intent is that we build terraform modules that perform a single task and assemble them when required. This improves the quality of the code and reliability of the terraform executions. Small components can be assembled into more elaborate collections.  

## Each module has a README.md
Check them out to discover dependencies, inputs and outputs.

## Deploy ICAP Clusters 

The rancher bootstrap is required to be online and functional before you provision the rancher clusters. To begin provisioning infrastructure make sure you have all the prerequirements setup in the Azure cloud then; 

## Steps

1. Deploy Rancher Server with the rancher-bootstrap terraform module, in [Rancher Bootstrap | develop](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/environments/develop/rancher-bootstrap) & [ Rancher Bootstrap | main ](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/environments/main/rancher-bootstrap). 

    a. change to the `cd environments/main/rancher-bootstrap`
    b. execute a `terraform init`
    b. execute a `terraform plan`
    c. execute a `terraform apply`

Once complete the output will contain the Rancher URL, Username, Password and ssh key, this key can be used to login to all the clusters services once deployed. 

2. Deploy the Base Clusters (a base cluster is a cluster that has 2 scalesets i.e 1 master and 1 worker node). 

    a. change to the `cd environments/main/rancher-clusters`
    b. execute a `terraform init`
    b. execute a `terraform plan`
    c. execute a `terraform apply`

Once complete the output will contain the load balancer urls which you can add to a standalone load balancer. The Clusters are configured to create 1 external facing load balancer per region, these load balancers fronts multiple cluster worker NodePorts in a single region.

A cluster deployment by default contains 2 regions, adding more regions is simple enough. You will need to expand on the IP allocation pattern we used to continue to create new regions with no overlapping cidr ranges. 

Take a look at the ICAP cluster map [here](https://github.com/filetrust/Glasswall-ICAP-Platform/blob/main/workspace/proto-multi-clusters/main.tf#L38)

1. Create a unique suffix for the region, increment an existing one like a,b,...d
2. Indexes are managed by terraform during the terraform run. 
3. Add the network config. 

    cluster_address_space        = var.icap_cluster_address_space_r3
    cluster_subnet_cidr          = var.icap_cluster_subnet_cidr_r3
    cluster_subnet_prefix        = var.icap_cluster_subnet_prefix_r3

4. That is it. 
5. Run terraform apply

# Networking rules in summary
1. We are dividing a /16 into /20s
2. This will give us a max deployment size of 15 regions.
3. We have only allocated 4 /20s
4. GW-ICAP gets the most /20s which are basically 1 per region.
5. GW-ADMIN uses the rancher network a /20
6. GW-FILEDROP uses a /24


3.  Change the Number of Workers in the Clusters and redeploy  
    a. change to the `cd environments/main/rancher-clusters`
    b. execute a `terraform plan`
    c. execute a `terraform apply`


To read more about the Glasswall ICAP Platform. The technical design documentation is here;
[ICAP Design Documentation](https://glasswallsolutionsltd-my.sharepoint.com/:w:/g/personal/pgerard_glasswallsolutions_com/EQyNuHOGDFNDmxTS282TGDABEke9OmBAz7pb872LA3BgfA?e=BlmDkL)
Access is restricted.

# How To

1. Clone the repo, execute `terraform init` in the root of the directory. 
2. Execute `terraform plan` to view the resources that will be created. This is an opportunity to look at naming conventions etc. 
3. Execute `terraform apply`. 
4. Got to the https endpoint on the ip in the output. 

## Requirements

A newish version of Terraform is required. 

```
terraform {
  required_version = ">= 0.13"
}
```

## Providers
- azurerm
- rancher2

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| linux\_vm\_public\_ips | n/a |
| tls\_private\_key | n/a |