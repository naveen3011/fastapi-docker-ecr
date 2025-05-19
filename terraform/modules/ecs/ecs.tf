resource "aws_ecs_cluster" "app_cluster" {
  name = var.app_cluster_name
}

resource "aws_cloudwatch_log_group" "ecs_task_log_group" {
  name = "/ecs/${var.app_task_family}"
  retention_in_days = 7
}

data "aws_caller_identity" "current" {}

# ECS Task Definition
resource "aws_ecs_task_definition" "app_task" {
  family                   = var.app_task_family
  container_definitions    = jsonencode([{
    name      = var.app_task_name
    image     = "${var.ecr_repo_url}:latest"
    essential = true
    memory    = 512
    cpu       = 256
    portMappings = [{
      containerPort = 8002
      hostPort      = 8002
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.ecs_task_log_group.name
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.execution_role}"
  depends_on               = [aws_cloudwatch_log_group.ecs_task_log_group]
}

# CloudWatch Events Rule to Schedule ECS Task every 2nd day of the month
resource "aws_cloudwatch_event_rule" "ecs_task_schedule" {
  name                = "${var.app_task_name}-schedule"
  description         = "Run ECS task every 2nd day of the month"
  schedule_expression = "cron(0 0 2 * ? *)"
}

# Event target for scheduled ECS task
resource "aws_cloudwatch_event_target" "ecs_task_target" {
  rule      = aws_cloudwatch_event_rule.ecs_task_schedule.name
  arn       = aws_ecs_cluster.app_cluster.arn
  role_arn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.execution_role}"

  ecs_target {
    task_definition_arn = aws_ecs_task_definition.app_task.arn
    task_count          = 1
    launch_type         = "FARGATE"
    network_configuration {
      subnets          = var.subnet_ids
      assign_public_ip = true
      security_groups  = var.security_group_ids
    }
  }
}
