module "resource_group" {
  source = "./modules/resource_group"  # Adjust the path to your resource_group module if necessary

  resource_group_name = "rg-eastasia-001"
  location            = var.location  # Use the default or specify another location
}
