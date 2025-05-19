locals {
  ecr_repo_name                = "${var.stage}-fastapi-docker-ecr-repo"
  app_cluster_name             = "${var.stage}-fastapi-docker-ecr-cluster"
  app_task_family              = "${var.stage}-fastapi-docker-ecr-task"
  app_task_name                = "${var.stage}-fastapi-docker-ecr-task"
  ecs_task_execution_role_name = "${var.stage}-fastapi-docker-ecr-execution-role"
  app_service_name             = "${var.stage}-fastapi-docker-ecr-service"
  availability_zones           = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
