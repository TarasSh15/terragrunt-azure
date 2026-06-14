variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_network" {
  type = list()
}

variable "subnet_cidr" {
  description = "Subnet CIDR blocks, minimum /27 CIDR"
  type = list()
}

variable "container_image" {
  type = string
}

variable "allocate_cpu" {
  type = number
}

variable "allocate_ram" {
  type = string
}

variable "target_port" {
  default = "Target port for container inside VNET"
  type = string
}

variable "max_replicas" {
  type = number
}

variable "min_replicas" {
  type = number
}
