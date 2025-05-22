resource "aws_ecs_task_definition" "main" {
  for_each                 = var.tasks
  family                   = "${var.meta.environment}-${var.meta.name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = local.container_definitions[each.key]

  tags = {
    Name = "${var.meta.environment}-${var.meta.name}"
  }
}
