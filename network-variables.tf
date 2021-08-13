#########################
## Network - Variables ##
#########################

variable "vpn-vnet-cidr" {
  type        = string
  description = "The CIDR of the VNET"
}

variable "vpn-gateway-subnet-cidr" {
  type        = string
  description = "The CIDR for the Gateway subnet"
}

variable "vpn-enpoint-subnet-cidr" {
  type        = string
  description = "The CIDR for the Endpoint subnet"
}