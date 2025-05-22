resource "aws_elasticache_replication_group" "main" {
  replication_group_id = local.name
  description          = local.name

  cluster_mode    = "disabled"
  node_type       = local.elasticache_node_type[var.environment]
  num_node_groups = 1

  at_rest_encryption_enabled = true

  transit_encryption_enabled = true
  transit_encryption_mode    = "required"

  subnet_group_name  = var.subnet_group_name
  security_group_ids = var.security_group_ids

  snapshot_retention_limit = 1

  tags = {
    Name = local.name
  }
}