variable "resource_group_name" {
  default     = "resumerg"
  description = "Used to populate the resource group name"
  type        = string
}

variable "resource_group_location" {
  default     = "north europe"
  description = "Used to populate the resource group location"
  type        = string
}

variable "storage_account_name" {
  default     = "resumestorageacc"
  description = "Used to populate the storage account name"
  type        = string
}

variable "resume_tags" {
  description = "Used to add tags to resources"
  type        = map(string)

  default = {
    project = "Resume"
  }
}