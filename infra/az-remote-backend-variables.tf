variable "project" {
  type = string
  description = "datafilm"
}
# environment
variable "environment" {
  type = string
  description = "Environment (prod)"
}
# azure region
variable "location" {
  type = string
  description = "Azure region where resources will be created"
  default = "west europe"
}