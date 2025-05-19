variable "app_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones in us-east-1"
  type        = list(string)
}

variable "app_task_family" {
  description = "ECS Task Definition Family"
  type        = string
}

variable "app_task_name" {
  description = "ECS Task Name"
  type        = string
}

variable "ecr_repo_url" {
  description = "ECR Repository URL (without tag)"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Name of the IAM role used for ECS task execution"
  type        = string
}

variable "app_service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "stage" {
  description = "The deployment stage (e.g., np, prod)"
  type        = string
  default     = "np"
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for ECS tasks"
  type        = list(string)
}
