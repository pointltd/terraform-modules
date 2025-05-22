locals {
  namespace = "/aws/ecs/${var.meta.environment}/${var.meta.name}"

  container_definitions = {
    for task_name, task in var.tasks : task_name => jsonencode([
      for container in task.containers : {
        name      = container.name
        image     = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.meta.name}/${task_name}:${container.image_tag}"
        essential = true
        portMappings = [
          for port in container.ports : {
            containerPort = port
          }
        ]
        environment = [
          for key, value in container.environment : {
            name  = key
            value = value
          }
        ]
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            "awslogs-group"         = aws_cloudwatch_log_group.main[task_name].name
            "awslogs-region"        = var.region
            "awslogs-stream-prefix" = "ecs"
          }
        }
      }
    ])
  }
}