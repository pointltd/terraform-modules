data "terraform_remote_state" "global" {
  backend = "s3"

  config = {
    bucket         = "partha-terraform-global"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "partha-terraform-lockid-global"
  }
}

data "aws_iam_role" "ecs_task_role" {
  name = data.terraform_remote_state.global.outputs.ecs_task_role_name
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = data.terraform_remote_state.global.outputs.ecs_task_execution_role_name
}

data "aws_vpc" "main" {
  id = var.meta.environment == "prod" ? data.terraform_remote_state.global.outputs.vpc_prod_id : data.terraform_remote_state.global.outputs.vpc_test_id
}

data "aws_security_group" "alb_public_security_group" {
  id = var.meta == "prod" ? data.terraform_remote_state.global.outputs.alb_security_group_id_prod : data.terraform_remote_state.global.outputs.alb_security_group_id_test
}

data "aws_alb_listener" "alb_public_listener" {
  arn = var.meta == "prod" ? data.terraform_remote_state.global.outputs.alb_public_listener_arn_prod : data.terraform_remote_state.global.outputs.alb_public_listener_arn_test
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