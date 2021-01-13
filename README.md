# Glasswall-ICAP-Platform

To read more about the Glasswall ICAP Platform. The technical design documentation is here;
[ICAP Design Documentation](https://glasswallsolutionsltd-my.sharepoint.com/:w:/g/personal/pgerard_glasswallsolutions_com/EQyNuHOGDFNDmxTS282TGDABEke9OmBAz7pb872LA3BgfA?e=BlmDkL)
Access is restricted.

### The environment modules
This directory contains the terraform backend and modules that load in modules from the workspace. It provides a easy mechanism of organising a one to many terraform deployment pattern. Terraform modules typically store the backend in the module and this is a useful pattern but in a case of a developer at Glasswall Solutions you want to be able to prototype your terraform code before you use it in production. Using this pattern enables you to have a manageable way to setup a new set of services by replicating a few modules and *setting up a new backend*. The organisation isnot strict but i have gone for organising the modules by git branch name `environments/branch/modules`. Where branch is the name of the branch you are currently on, the backend uses the branch to differentiate backends. 

# Installer
The installer module is where you should start, in the following order execute the terraform runs.

### TFVARS
Saving time with some variables with tfvars. The following variables do not change across all the terraform modules, which makes them a perfect candidate for using tfvars. 
```
    organisation           = ""
    environment            = ""
    azure_region           = "" 
    tenant_id              = ""
    subscription_id        = ""
```
Anything not in the above list should be managed at the module level. However the above will save you quite a bit of duplication. Modify each terraform run with; 

```terraform apply -var-file="../common.tfvars"```

### 1. 01_terraform-remote-state
This stage sets up the underlying storage of the terraform backends, note the outputs because all stages rely on information from the outputs of this module. 

Before you begin you will need the following details and a valid azure login account. Once you've executed `az login` you will need the following information.

```
    organisation           = "" # this just needs to be a short identifier (i.e gw
    environment            = "" # can be anything short to identify this stacks change management tier
    azure_region           = "" # which azure region do you want to use ?
    tenant_id              = "" # this is based on your azure account
    subscription_id        = "" # this is based on your azure account
```
Add this information to the environments/installer/01_terraform-remote-state/main.tf

Run `terraform init`, then `terraform plan`, then `terraform apply`.

Take note of the outputs because you will need them in all the next stages.

### 2. 02_container-registry
This stage creates the container registry which will store all of the container images. You will need this before continuing with any steps related to the setup of the git server (part of ```03_rancher-bootstrap```).

Using the terraform outputs from 01_terraform-remote-state fill in the following details;
```main.tf``` in environments/installer/02_container-registry/main.tf on line 2.

```
    terraform {
        backend "azurerm" {
            resource_group_name  = ""
            storage_account_name = ""
            container_name       = ""
            #backend_key_container_registry_02
            key                  = ""
        }
    }
```
Once complete copy the same information you used for;
```
    organisation           = "" # this just needs to be a short identifier (i.e gw
    environment            = "" # can be anything short to identify this stacks change management tier
    azure_region           = "" # which azure region do you want to use ?
    tenant_id              = "" # this is based on your azure account
    subscription_id        = "" # this is based on your azure account
```
Run `terraform init`, then `terraform plan`, then `terraform apply`.

### 3. 03_rancher-bootstrap
This stage creates the rancher server which will be used to setup the kubernetes clusters. Using the information from the 01_terraform-remote-state add the necessary information the the terraform backend configuration in the main.tf in environments/installer/03_rancher-bootstrap/main.tf
```
terraform {
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    # backend_key_rancher_bootstrap_03
    key                  = ""
  }
}
```
Like in the previous steps fill in this information.

```
    organisation           = "" # this just needs to be a short identifier (i.e gw
    environment            = "" # can be anything short to identify this stacks change management tier
    azure_region           = "" # which azure region do you want to use ?
    tenant_id              = "" # this is based on your azure account
    subscription_id        = "" # this is based on your azure account
```
Run `terraform init`, then `terraform plan`, then `terraform apply`.

There is quite a bit of information in the Rancher output. Most importantly is the following information;

`tls_private_key`
You will need this to ssh into the rancher server to access the clusters. 

`rancher_api_url`
Use this to access the rancher web console.

`rancher_user`
The login user

`rancher_password`
The login password


### 4. 04_rancher-clusters
This stage creates the clusters that run the ICAP service.

### The workspace modules
This directory contains assembled terraform components which define a component in the final delivery infrastructure. Entities like the Rancher server, and the Clusters are assembled in the workspace as well as pre-prequisites like state storage, secrets management and a container registry.

1. [Terraform Remote State](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/workspace/terraform-remote-state)
2. [Container Registry](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/workspace/container-registry)
3. [Rancher Bootstrap](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/workspace/rancher-bootstrap)
4. [ICAP Multi Cluster No Vault](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/workspace/icap-multi-cluster-no-vault)

### The modules directory is for reusable resource collections or single resource terraform modules 
This directory contains many module libraries and one meta module ('gw'). The intent is that we build terraform modules that perform a single task and assemble them when required. This improves the quality of the code and reliability of the terraform executions. Small components can be assembled into more elaborate collections.  

## Each module has a README.md
Check them out to discover dependencies, inputs and outputs.


## Deploy ICAP Clusters at Glasswall

## Pre-requisites

In order to follow along with this guide you will need the following tools installed locally:

- Terraform (v0.13.5 or higher)
- AZ CLI - with permissions to create resources
- Bash (or similar) terminal

To begin provisioning infrastructure make sure you have all the necessary permissions to create resources in the Azure cloud then follow the steps below: 

## Steps

1. Create Azure Storage to store terraform remote state in [terraform-remote-state](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/workspace/terraform-remote-state)
   
    a. execute a `terraform init`

    b. execute a `terraform plan`

    c. execute a `terraform apply`

2. Create Azure Key Vault to store secret values in [key-vault](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/modules/azure/key-vault)

   a. execute a `terraform init`

   b. execute a `terraform plan`

   c. execute a `terraform apply`

3. Create Azure Container Registry to store Docker images in [container-registry](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/workspace/container-registry)

   a. execute a `terraform init`

   b. execute a `terraform plan`

   c. execute a `terraform apply`
   
4. Deploy Rancher Server with the rancher-bootstrap terraform module, in [Rancher Bootstrap | develop](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/environments/develop/rancher-bootstrap) & [ Rancher Bootstrap | main ](https://github.com/filetrust/Glasswall-ICAP-Platform/tree/main/environments/main/rancher-bootstrap). 

    a. change to the `cd environments/main/rancher-bootstrap`
   
    b. execute a `terraform init`
   
    c. execute a `terraform plan`
   
    d. execute a `terraform apply`

Once complete the output will contain the Rancher URL, Username, Password and ssh key, this key can be used to login to all the clusters services once deployed.
The rancher bootstrap is required to be online and functional before you provision the rancher clusters.

5. Deploy the Base Clusters (a base cluster is a cluster that has 2 scalesets i.e 1 master and 1 worker node). 

    a. change to the `cd environments/main/rancher-clusters`
   
    b. execute a `terraform init`
   
    c. execute a `terraform plan`
   
    d. execute a `terraform apply`

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
    
