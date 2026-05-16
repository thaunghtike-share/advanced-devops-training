output "vm_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "copied_file_path" {
  value = "/tmp/message.txt"
}
