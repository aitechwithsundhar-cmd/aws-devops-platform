variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "sg_names" {
  description = "List of security groups to create"
  type        = list(string)
}