variable "project" {
  type = string
  description = "datafilm"
  default     = "datafilm"
}
# environment
variable "environment" {
  type = string
  description = "Environment (prod)"
  default     = "default-environment-value"
}
# azure region
variable "location" {
  type = string
  description = "Azure region where resources will be created"
  default = "west europe"
}