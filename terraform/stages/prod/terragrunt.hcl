include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../modules/homework_inf"
}

locals{
  environment = basename(get_terragrunt_dir())
}

inputs = {
  environment = local.environment
  location    = "westeurope"

  vnet_network = ["10.3.0.0/16"]
  subnet_cidr  = ["10.3.1.0/24"]

  target_port     = "80"
  allocate_cpu    =  1.0
  allocate_ram    = "2Gi"
  container_image = "nginx:latest"
  
  min_replicas = 1
  max_replicas = 10
}
