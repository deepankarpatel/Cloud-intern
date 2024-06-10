
module "load_balancer" {
  source = "../../Modules/Load_Balancer"
  resource_group_name = "veronica"
  lb_name = "myLoad"
}