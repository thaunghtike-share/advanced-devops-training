# --- PUBLIC IP ---
resource "azurerm_public_ip" "pip" {
  name                = "pip-OPENVPN-SERVER"
  location            = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].location
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# --- NETWORK SECURITY GROUP ---
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-OPENVPN-SERVER"
  location            = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].location
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Dynamic block ကို var.vms ထဲက list အတိုင်း ဆက်သုံးထားပါတယ်
  dynamic "security_rule" {
    for_each = var.vms["OPENVPN-SERVER"].additional_inbound_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = security_rule.value.protocol == "*" ? "Tcp" : security_rule.value.protocol
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = security_rule.value.source
      destination_address_prefix = "*"
    }
  }
}

# --- NETWORK INTERFACE ---
resource "azurerm_network_interface" "nic" {
  name                  = "nic-OPENVPN-SERVER"
  location              = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].location
  resource_group_name   = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "internal"
    # Networking output မှ Cleaned Map ကို ပြန်ညွှန်းထားခြင်း
    subnet_id                     = data.terraform_remote_state.network.outputs.subnet_ids[var.vms["OPENVPN-SERVER"].subnet_key]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# --- NSG & NIC ASSOCIATION ---
resource "azurerm_network_interface_security_group_association" "assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# --- VIRTUAL MACHINE ---
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "OPENVPN-SERVER"
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].name
  location            = data.terraform_remote_state.rg.outputs.resource_groups["mahar"].location
  size                = var.vms["OPENVPN-SERVER"].size
  admin_username      = var.vms["OPENVPN-SERVER"].admin_username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.vms["OPENVPN-SERVER"].admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}