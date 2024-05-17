variable "my_map" {
  type = map
}

output "map_output" {
  value = var.my_map
}

#this is a hello world program of map data type after running this program
# it will ask you for value you have to enter the value in the form of map
# for example {"red"="white", "name"= "value"} like this. so it will give you output
# also you can add default values like this {"red"="white", "name"= "value"}