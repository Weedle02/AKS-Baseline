variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "prefix" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "node_vm_size" {
  type    = string
  default = "Standard_DS4_v2"
}

variable "node_count" {
  type    = number
  default = 3
}

variable "tags" {
  type    = map(string)
  default = {}
}
