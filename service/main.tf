resource "aws_ecs_service" "main" {
  for_each               = var.services
  name                   = each.value.name
  cluster                = var.cluster_id
  task_definition        = each.value.task_definition_arn
  desired_count          = 1
  launch_type            = "FARGATE"
  enable_execute_command = true
  wait_for_steady_state  = true

  propagate_tags = "TASK_DEFINITION"

  network_configuration {
    subnets         = each.value.subnets
    security_groups = each.value.security_groups
  }

  dynamic "load_balancer" {
    for_each = each.value["listeners"]

    content {
      target_group_arn = aws_alb_target_group.main["${each.key}-${load_balancer.key}-${var.meta.environment}"].arn
      container_name   = load_balancer.key
      container_port   = load_balancer.value["port"]
    }
  }

  tags = {
    Name = each.value.name
  }
}
