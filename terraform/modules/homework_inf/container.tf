resource "azurerm_log_analytics_workspace" "hwm_logs" {
  name                = "${var.environment}-hwm-law"
  location            = var.location
  resource_group_name = azurerm_resource_group.rs-group.name

  sku               = "PerGB2018"
  retention_in_days = 30
}


resource "azurerm_container_app_environment" "hwm_cae" {
  name                       = "${var.environment}-hwm-cae"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rs-group.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.hwm_logs.id

  infrastructure_subnet_id = azurerm_subnet.hwm_subnet.id
}

resource "azurerm_container_app" "hwm_app" {
  name                         = "${var.environment}-hwm-app"
  resource_group_name          = azurerm_resource_group.rs-group.name
  container_app_environment_id = azurerm_container_app_environment.hwm_cae.id

  revision_mode = "Multiple"

  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = "${var.environment}-hwm-app"
      image  = var.container_image
      cpu    = var.allocate_cpu
      memory = var.allocate_ram
    }
  }

  ingress {
    external_enabled = false
    target_port      = var.target_port
    traffic_weight {
        latest_revision = true
        percentage      = 100
    }
  }
}
