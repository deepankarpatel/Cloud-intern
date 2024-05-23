
data "local_file" "text" {
  filename = "${path.module}/demo.txt"
}

output "data" {
  value = data.local_file.text.content
}

#this code will read the data from local file demo.txt and show it as the output