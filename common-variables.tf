#############################
## Common - Variables ##
#############################

# app name 
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}


# company prefix 
variable "prefix" {
  type        = string
  description = "This variable defines the company name prefix used to build resources"
}

# azure region
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "UK South"
}

# user or company environment
variable "owner" {
  type        = string
  description = "This variable defines the owner to be built"
}

# root certificate
variable "cert_root_name" {
  type        = string
  description = "This variable defines the root certificate"
}
