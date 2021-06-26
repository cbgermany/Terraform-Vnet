# INTRODUCTION

This is a Terraform module to create an Azure VNET.  The module will create new resource_group for the VNET and wull create the associated subnets and network security groups associated with the subnet.  In addirion the module allows for a DDOS Protection plan to be created om the VNET.

## Objectives

The module will create the initial resource group and networking for the following:

* Network resource group
* Inital VNET
* Subnet(s)
* Gateway Subnet - Must be called GatewaySubnet (Optional)
* Vritual Network Gateway if gateway subnet is supplied
* DDOS Protection plan (optional)

## Usage

```hcl
module "vnet" {
    source = "../../modules/Terraform-vnet"

    name           = "my-vnet"
    location       = "UK South"
    resource_group = "rg1"
    address_space  = ["10.0.0.0/16"]

    subnets = {
      subnet-1 = {
        name              = "FrontEnd"
        cidr              = "10.0.0.0/24"
        service_endpoints = []
      },
      subnet-2 = {
        name              = "BackEnd",
        cidr              = "10.0.1.0/24"
        service_endpoints = []
      }
    }

    create_ddos     = false

    common_tags     = {map of tags}

    create_gateway_vpn = true
    gateway_subnet     = "10.25.254.0/28"
    vpn_clients        = ["10.26.0.0/24", "10.26.1.0/24"]
    create_ddos        = false
}
```
In the example above the subnets will be called Sysman, FrontEnd and BackEnd, the GatewaySubnet will be used for the VPN gateway. 

## Parameters

* **create_vnet**: Flag to indicate whether or not to create the VNET

* **create_gateway_vpn**: Flag to indicate whether or not to create the VPN

* **name**: The name of the VNET

* **location**: The Region/Location where the VNET will be created

* **resource_group**: The name of the VNET resource group

* **address_space**: The CIDR block of the VNET

* **subnet_prefixes**: List of the Subnet prefixes

* **subnets**: Map of the Subnets

* **gateway_subnet**: The Gateway Subnet for the VPNs, there can only be one and the Subnet will be Called GatewaySubnet

* **vpn_clients**: List of vpn client subnets that will be for the availability zones

* **common_tags**: The common tags applied to resources

## Outputs

## Author

Chris Germany
