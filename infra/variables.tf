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

variable "object_ids" {
  description = "Used to give permission to both myself and the pipeline"
  type        = map(string)
  default = {
    my_id = "c938b2ab-94b5-42d7-b3a6-6408172d54e2"
    sp_id = "4d1cf86a-1af9-4cbc-ae64-61bedc0b284b"
  }
}