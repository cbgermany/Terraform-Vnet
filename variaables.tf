# This defines the list of variables used

variable "create_vnet" {
  description = "Controls if the VNET should be created (affects all resources)"
  default     = true
}

variable "create_gateway_vpn" {
  description = "Controls whether a gateway VPN is created"
  default     = false
}

variable "name" {
  description = "The name of the VNET"
  default     = "VNet1"
}

variable "location" {
  description = "The Region/Location where the Vnet should be created"
  default     = "UK South"
}

variable "resource_group" {
  description = "The resource group associated with the VNET"
  default     = "n133saprsg_vnet1"
}

variable "address_space" {
  description = "The CIDR block of the Nnet"
  default     = "172.25.0.0/16"
}

variable "subnet_prefixes" {
  description = "The subnet prefixes"
  type        = "list"
  default     = []
}

variable "subnet_names" {
  description = "The name of the subnets"
  type        = "list"
  default     = []
}

variable "gateway_subnet" {
  description = "The gateway subnets for the VPN, there can only be one"
}

variable "dns_servers" {
  description = "The list of DNS servers for the Virtual network"
  type        = "list"
}

variable "vpn_clients" {
  description = "The CIDR block range from wich IP addresses will be assigned to clients connecting by VPN"
  type        = "list"
  default     = []
}

variable "common_tags" {
  description = "A Map of common tags to assign to the network security group"
  type        = "map"
}

variable "certificate_data" {
  description = "The Client Root cert data"
  default = "MIIC5zCCAc+gAwIBAgIQRMrgWxlkZ7hJde05xksCrTANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtQMlNSb290Q2VydDAeFw0xODAzMDcxNzQyMDhaFw0xOTAzMDcxODAyMDhaMBYxFDASBgNVBAMMC1AyU1Jvb3RDZXJ0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtLqlzPJpNAm/SW436wBDDm10EO9Vm+o+HuGWdbtHHIekpU8Q1/zQEcibf8TWwV2P3LHnPJ9gMHDbltQBAZclBxwBZSSlLVQxGEXEI8x2jW+WNRpLo7fFBSCQvlvadxfEcsvcPR6PooJ6N4ioq+SD9mokf3nr2qwd3Ax2dguaBczZoP9oWOqfASfyihI2EbUO+67NZNL76ELef5+EhCG38AzInpewyIVsOCecB8SSbaUOnxvE/jfGlHjfwukmL0qCOj7cXCO1o/14rtNjlM1xiB4qJtBa10dUpMzkxJCPf3cQs1+6XmXRw97mPQ/XJGdhbniN9Gc0/A3yb78afsyTWQIDAQABozEwLzAOBgNVHQ8BAf8EBAMCAgQwHQYDVR0OBBYEFN+q56AjARjzgtmZAtfyUW5wvs0QMA0GCSqGSIb3DQEBCwUAA4IBAQAJCzS0kwkA3d24+i8GVVX3ej7ZXfoJN22s6jY16jHH1GRyUNuJoCCnLFnN/09FsW6UpA/JE69lPaQf8S/4uecO/FJ3cbO2DNmpdDAZkDP71a6+IANbe/Jk2/6lhKM4cxpPa6fEhTRcZuXtMzW2y3AfRw3O+R2mpf1FiSbcp1yQmBGg5sgrrdMYvanLCScgnYDczIfKQaAoU3eOtx4Q3Tv9sWZp4pupcwgNg0stBkKykBJsa3WlrxQECLA0iLAKoa+l6lI5M0eG8REfBZTJ8wd+qfbbeMu4diuEdmETHcA3CqGmY1uVhuCkVFGYN/fPtWwEkOETI2R3PS/az/ACnyM0"
}

variable "create_ddos" {
  description = "Flag to indicate whether a DDOS protection plan should be created"
  default = false
}

# Convert the boolean into a list that can then be processed in the azure_virtual_vnet resource
locals {
  ddos_enabled = var.create_ddos ? [{}] : []
}