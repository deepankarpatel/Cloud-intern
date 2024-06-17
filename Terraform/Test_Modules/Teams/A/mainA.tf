

module "virtul_machine" {
  source              = "../../Modules/Virtual_machine"
  vm_name             = "cloud"
  rg_name             = "myGroup"
  username            = "cloud"
  password            = "cloud@1234567"
}


output "public_ip_address" {
  value = module.virtul_machine.virtual_ip.public_ip_address
}