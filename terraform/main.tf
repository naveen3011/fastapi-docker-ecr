terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "ecrRepo" {
  source = "./modules/ecr"

  ecr_repo_name = local.ecr_repo_name
}

module "ecsCluster" {
  source = "./modules/ecs"

  app_cluster_name             = local.app_cluster_name
  availability_zones           = local.availability_zones
  app_task_famliy              = local.app_task_famliy
  ecr_repo_url                 = module.ecrRepo.repository_url
  app_task_name                = local.app_task_name
  ecs_task_execution_role_name = local.ecs_task_execution_role_name
  app_service_name             = local.app_service_name
}
