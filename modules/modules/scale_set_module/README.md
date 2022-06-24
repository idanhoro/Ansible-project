# Scale set module
In this module we create and configure the virtual network scale set.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.app_scale_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password of the instances | `string` | n/a | yes |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | The username of the instances | `string` | n/a | yes |
| <a name="input_app_public_subnet_id"></a> [app\_public\_subnet\_id](#input\_app\_public\_subnet\_id) | The resource's ID of the public subnet | `string` | n/a | yes |
| <a name="input_app_public_subnet_nsg_id"></a> [app\_public\_subnet\_nsg\_id](#input\_app\_public\_subnet\_nsg\_id) | The resource's ID of the public subnet network security group | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to create using the scale set | `number` | n/a | yes |
| <a name="input_lb_pool_id"></a> [lb\_pool\_id](#input\_lb\_pool\_id) | The resource's ID of the load balancer pool | `string` | n/a | yes |
| <a name="input_lbnatpool_id"></a> [lbnatpool\_id](#input\_lbnatpool\_id) | The resource's ID of the load balancer nat rules pool | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | The resource group service location | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name | `string` | n/a | yes |
| <a name="input_scale_set_sku_model"></a> [scale\_set\_sku\_model](#input\_scale\_set\_sku\_model) | Model of virtual machine for the scale set instances | `string` | n/a | yes |
| <a name="input_web_app_name"></a> [web\_app\_name](#input\_web\_app\_name) | The web appliction name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_scale_set_password_output"></a> [scale\_set\_password\_output](#output\_scale\_set\_password\_output) | n/a |
<!-- END_TF_DOCS -->