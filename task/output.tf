output "task_definitions" {
  value = {
    for key, task in aws_ecs_task_definition.main : key => task.arn
  }
}