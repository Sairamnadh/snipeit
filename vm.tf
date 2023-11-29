resource "azurerm_resource_group" "ram_rg" {
  name     = "tf_test"
  location = "East US"
}

resource "azurerm_virtual_network" "ram_vnet" {
  name                = "sai_vnt"
  address_space       = ["10.0.0.0/16", "172.20.0.0/16"]
  location            = azurerm_resource_group.ram_rg.location
  resource_group_name = azurerm_resource_group.ram_rg.name
}

resource "azurerm_subnet" "ram_sb" {
  name                 = "snipeit_test"
  resource_group_name  = azurerm_resource_group.ram_rg.name
  virtual_network_name = azurerm_virtual_network.ram_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "ram_srg" {
  name                = "sai-nsg"
  location            = azurerm_resource_group.ram_rg.location
  resource_group_name = azurerm_resource_group.ram_rg.name

  security_rule {
    name                       = "http"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "ram_public_ip" {
  name                = "sai-public-ip"
  location            = azurerm_resource_group.ram_rg.location
  resource_group_name = azurerm_resource_group.ram_rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "ram_nif" {
  name                = "sai-nic"
  location            = azurerm_resource_group.ram_rg.location
  resource_group_name = azurerm_resource_group.ram_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ram_sb.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ram_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "test_snipeit" {
  name                = "testsai"
  location            = azurerm_resource_group.ram_rg.location
  resource_group_name = azurerm_resource_group.ram_rg.name
  size                = "Standard_D2s_v3"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-Ubuntu-Server-jammy"
    sku       = "22_04-LTS"
    version   = "latest"
  }

  admin_username = var.username
  admin_password = var.password

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.username
    public_key = var.ssh_public_key
  }

  network_interface_ids = [azurerm_network_interface.ram_nif.id]

  provisioner "remote-exec" {
    inline = [file("${path.module}/script.sh")]

    connection {
      type        = "ssh"
      user        = var.username
      private_key = var.ssh_private_key
      host        = azurerm_public_ip.ram_public_ip.ip_address
    }
  }
}
output "public_ip_address" {
  value = azurerm_linux_virtual_machine.test_snipeit.public_ip_addresses
}
