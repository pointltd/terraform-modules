resource "aws_cloudwatch_log_group" "main" {
  for_each          = var.tasks
  name              = "${local.namespace}/${replace(each.key, "_", "-")}"
  retention_in_days = 90
}