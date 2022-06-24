<!-- BEGIN_TF_DOCS -->
# Setup module
In this module we set up the variables at the input ready to use in modules.

```
{
  "production": "production",
  "staging": "staging"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_environment_settings"></a> [environment\_settings](#module\_environment\_settings) | ../modules/environment | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password of the instances | `string` | n/a | yes |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | The username of the instances | `string` | n/a | yes |
| <a name="input_allowed_ip_address"></a> [allowed\_ip\_address](#input\_allowed\_ip\_address) | The ip/s are allowed to connect with ssh to the web application servers | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to create using the scale set | `number` | n/a | yes |
| <a name="input_postgres_password"></a> [postgres\_password](#input\_postgres\_password) | Password of the postgresql database | `string` | n/a | yes |
| <a name="input_postgres_sku_model"></a> [postgres\_sku\_model](#input\_postgres\_sku\_model) | Model of virtual machine for the database | `string` | n/a | yes |
| <a name="input_postgres_username"></a> [postgres\_username](#input\_postgres\_username) | Username of the postgresql database | `string` | n/a | yes |
| <a name="input_private_subnet_address_space"></a> [private\_subnet\_address\_space](#input\_private\_subnet\_address\_space) | The private subnet address space X.X.X.X - X.X.X.X | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key used to encrypt and decrypt messages in network | `string` | n/a | yes |
| <a name="input_public_subnet_address_space"></a> [public\_subnet\_address\_space](#input\_public\_subnet\_address\_space) | The public subnet address space X.X.X.X - X.X.X.X | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | The resource group service location | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Map different kinds of environment | `map` | <pre>{<br>  "production": "production",<br>  "staging": "staging"<br>}</pre> | no |
| <a name="input_scale_set_sku_model"></a> [scale\_set\_sku\_model](#input\_scale\_set\_sku\_model) | Model of virtual machine for the scale set instances | `string` | n/a | yes |
| <a name="input_virtual_network_address_space"></a> [virtual\_network\_address\_space](#input\_virtual\_network\_address\_space) | The virtual network address space X.X.X.X - X.X.X.X | `string` | n/a | yes |
| <a name="input_web_app_name"></a> [web\_app\_name](#input\_web\_app\_name) | The web appliction name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->