data "aws_vpc" "main" {
  id = var.meta.environment == "prod" ? data.terraform_remote_state.global.outputs.vpc_id_prod : data.terraform_remote_state.global.outputs.vpc_id_test
}

data "aws_security_group" "lb_public_security_group" {
  id = var.meta == "prod" ? data.terraform_remote_state.global.outputs.lb_security_group_id_prod : data.terraform_remote_state.global.outputs.lb_security_group_id_test
}

data "aws_security_group" "lb_private_security_group" {
  id = var.meta == "prod" ? data.terraform_remote_state.global.outputs.lb_security_group_id_prod : data.terraform_remote_state.global.outputs.lb_security_group_id_test
}

data "aws_security_group" "ecs_security_group" {
  id = var.meta == "prod" ? data.terraform_remote_state.global.outputs.ecs_security_group_id_prod : data.terraform_remote_state.global.outputs.ecs_security_group_id_test
}

data "aws_security_group" "redis_security_group" {
  id = var.meta == "prod" ? data.terraform_remote_state.global.outputs.redis_security_group_id_prod : data.terraform_remote_state.global.outputs.redis_security_group_id_test
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Type = "private"
  }
}

data "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name = var.meta == "prod" ? data.terraform_remote_state.global.outputs.elasticache_subnet_group_name_prod : data.terraform_remote_state.global.outputs.elasticache_subnet_group_name_test
}
