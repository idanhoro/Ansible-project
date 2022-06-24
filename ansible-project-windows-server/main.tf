provider "azurerm" {
  features {}
}
# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name 
  location = var.location
}
# Create a virtual network
resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.rg_name}-vnet"
  address_space       = var.address_space_virtual_network
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
# Create private subnet
resource "azurerm_subnet" "private_subnet" {
  name                 = "private_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.address_space_private_subnet
  service_endpoints = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action",]
    }
  }
}

# Create public subnet for web app
resource "azurerm_subnet" "public_subnet" {
  name                 = "public_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.address_space_public_subnet 
}

# Create public ip for load balancer

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   ="windows-database-server-postgres-idanho55"

}

# Create intgration resorce between the virtual network and the subnets.
resource "azurerm_network_interface" "network_intgration" {
  name                = "network_int_web"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id =  azurerm_public_ip.public_ip.id
  }
}
# Create WINDOWS virtual machine
resource "azurerm_windows_virtual_machine" "web-app-virtual-machine" {
  name                = "web-app-virtual-machine"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.network_intgration.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# associate private subnet to network security group

resource "azurerm_subnet_network_security_group_association" "private_nsg_association" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}


# associate public subnet to network security group

resource "azurerm_subnet_network_security_group_association" "public_nsg_association" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}


# public security configh
resource "azurerm_network_security_group" "public_nsg" {
  name                = "public_nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "rdp"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3389"
    destination_port_range     = "*"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "port_5985"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "5985"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "port_22"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*" 
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_8080"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "Deny"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# private network security group.

resource "azurerm_network_security_group" "private_nsg" {
  name                = "private_nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Postgres"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "5432"
    destination_port_range     = "5432"
    source_address_prefix      = var.address_space_public_subnet[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "controller access"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "5985"
    destination_port_range     = "5985"
    source_address_prefix      = var.address_space_public_subnet[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

#  Create private DNS for the database.
resource "azurerm_private_dns_zone" "database_private_dns" {
  name                = "win-server-idanho55-.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
  
}



#  Create managed postgres flexiable server

resource "azurerm_postgresql_flexible_server" "postgres_database_server" {
  name                   = "poc-database-name"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "12" 
  delegated_subnet_id    = azurerm_subnet.private_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.database_private_dns.id
  administrator_login    = var.database_username
  administrator_password = var.database_password
  zone                   = "1"
  create_mode            = "Default"
  storage_mb             = 32768


  sku_name = "B_Standard_B1ms"

  depends_on = [azurerm_private_dns_zone_virtual_network_link.Link_DNS_to_virtual_network]

}

#  Database configuration

resource "azurerm_postgresql_flexible_server_database" "database" {
  name      = "database"
  server_id = azurerm_postgresql_flexible_server.postgres_database_server.id
  collation = "en_US.utf8"
  charset   = "utf8"

}

#  Configure FW rules

resource "azurerm_postgresql_flexible_server_firewall_rule" "FW_rule-datbase-server" {
  name      = "postgres"
  server_id = azurerm_postgresql_flexible_server.postgres_database_server.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"

}

resource "azurerm_postgresql_flexible_server_configuration" "flexible_server_configuration" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.postgres_database_server.id
  value     = "off"

}


#  link DNS zone to the virtual network.

resource "azurerm_private_dns_zone_virtual_network_link" "Link_DNS_to_virtual_network" {
  name                  = "Link_DNS_to_virtual_network"
  private_dns_zone_name = azurerm_private_dns_zone.database_private_dns.name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
  resource_group_name   = azurerm_resource_group.rg.name
}