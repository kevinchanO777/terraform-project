variable "resource_group_name" {
  default = "Dev-Machine-Resource-Group"
}

variable "azurerm_virtual_network" {
  default = "Dev-Machine-Virtual-Network"
}

variable "path_to_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "admin_username" {
  type        = string
  nullable    = false
  description = "Enter admin USERNAME for the virtual machine: "
}

variable "dev_number" {
  type        = number
  nullable    = false
  description = "Enter your dev number: "
  validation {
    condition     = var.dev_number > 0 && var.dev_number < 1000
    error_message = "Must be a valid number between 1 - 1000"
  }
}