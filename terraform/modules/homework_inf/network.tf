resource "azurerm_network_security_group" "nsg" {
  name                = "${var.environment}-hmw-security-group"
  location            = azurerm_resource_group.rs-group.location
  resource_group_name = azurerm_resource_group.rs-group.name

  # Outbound rule: Allow all traffic
  security_rule {
    name                       = "Allow-All-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_virtual_network" "hwm-network" {
  name                = "${var.environment}-hmw-network"
  location            = azurerm_resource_group.rs-group.location
  resource_group_name = azurerm_resource_group.rs-group.name
  address_space       = var.vnet_network

}

resource "azurerm_subnet" "hwm_subnet" {
  name                 = "${var.environment}-hwm-subnet"
  resource_group_name  = azurerm_resource_group.rs-group.name
  virtual_network_name = azurerm_virtual_network.hwm-network.name
  address_prefixes     = var.subnet_cidr

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
        ]
    }
  }
}
