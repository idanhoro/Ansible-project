variable "rg_name" {
  type= string
  description = "Resorce group name"
}
variable "address_space_virtual_network" {
  type    = list(any)
  description = "virtual network address space"

}

variable "address_space_public_subnet" {
  type    = list(any)
  description = "address space public subnet"

}

variable "address_space_private_subnet" {
  type    = list(any)
  description = "address space private subnet"

}

variable "location" {
  type        = string
  description = "Server location"

}

variable "admin_username" {
  type        = string
  description = "VM admin username"
}
variable "admin_password" {
  type        = string
  description = "VM admin passowrd"
}

variable "database_username" {
  type = string
  description = "Database username"
}

variable "database_password" {
  type = string
  description = "Database passowrd"
}

variable "allowed_ip" {
  type        = string
  description = "allowed ip address to connect"
}
