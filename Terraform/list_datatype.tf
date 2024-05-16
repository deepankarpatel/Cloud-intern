variable "my_list" {
    type = list
}

output "variable_value" {
  value = var.my_list
}