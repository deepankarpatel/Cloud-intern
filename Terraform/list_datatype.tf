variable "my_list" {
    type = list
    default = ["game", "name", "me", "know"]
}

output "variable_value" {
  value = var.my_list
}
#this is a hello world program of list data type after running this program
# it will ask you for value you have to enter the value in the form of list
# for example ["hii", "hello", "how are you"] like this. so it will give you output
# also you can add default values like this ["hii", "hello", "how are you"]