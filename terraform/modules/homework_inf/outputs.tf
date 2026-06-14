output "vnet_id" {
  value = azurerm_virtual_network.hwm-network.id
}

output "containerapps_subnet_id" {
  value = azurerm_subnet.hwm_subnet.id
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.hwm_logs.id
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.hwm_logs.name
}

output "container_app_fqdn" {
  value = azurerm_container_app.hwm_app.latest_revision_fqdn
}

output "container_app_id" {
  value = azurerm_container_app.hwm_app.id
}
