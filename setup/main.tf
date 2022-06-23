module "environment_settings" {
  source              = "../modules/environment"
  for_each            = var.resource_group_name
  resource_group_name = each.value

  admin_password                = var.admin_password
  admin_user                    = var.admin_user
  allowed_ip_address1            = var.allowed_ip_address1
  allowed_ip_address2            = var.allowed_ip_address2
  instance_count                = var.instance_count
  postgres_password             = var.postgres_password
  postgres_sku_model            = var.postgres_sku_model
  postgres_username             = var.postgres_username
  private_subnet_address_space  = var.private_subnet_address_space
  public_key                    = var.public_key
  public_subnet_address_space   = var.public_subnet_address_space
  resource_group_location       = var.resource_group_location
  scale_set_sku_model           = var.scale_set_sku_model
  virtual_network_address_space = var.virtual_network_address_space
  web_app_name                  = var.web_app_name
}
