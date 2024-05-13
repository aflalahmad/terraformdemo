variable "resource_group" {
    type = string

    validation {
      condition = length(var.resource_group)>0
      error_message = "the resource group must not be empty"
    }
    validation {
      condition = can(regex("^[a-z0-9-]{3,24}$",var.resource_group))
      error_message = " resource group must between 3 and 24 only lower case allowed and numbers and dashes"
    }

  
}

variable "location" {
    type = string
  validation {
    condition = length(var.location)>0
    error_message = "value must bnot be empty"
  }
}

variable "storageaccount" {
    type = string

    validation {
      condition = can(regex("^[a-z0-9-]{3,24}$",var.storageaccount))
      error_message = "resource group must between 3 and 24 only lower case allowed and numbers and dashes"
    }
  
}

variable "account_replication_type" {
    type = string
    validation {
      condition = var.account_replication_type != "LRS" || var.account_replication_type != "ZRS"
      error_message = "value must be either LRS and ZRS"
      }
  
}