output "redis_security_group" {
    value = data.aws_security_group.redis_security_group
}

output "elasticache_subnet_group" {
    value = data.aws_elasticache_subnet_group.elasticache_subnet_group
}