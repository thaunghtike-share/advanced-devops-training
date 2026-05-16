output "vm_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "remote_file_path" {
  value = "/tmp/remote-exec-demo.txt"
}
