output "ecs_security_group" {
    value = data.aws_security_group.ecs_security_group
}

output "redis_security_group" {
    value = data.aws_security_group.redis_security_group
}

output "elasticache_subnet_group" {
    value = data.aws_elasticache_subnet_group.elasticache_subnet_group
}

output "private_subnets" {
    value = data.aws_subnets.private
}

output "lb_public_listener" {
    value =  data.aws_alb_listener.lb_public_listener
}