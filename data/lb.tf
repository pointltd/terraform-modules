data "aws_alb_listener" "lb_public_listener" {
  arn = var.meta == "prod" ? data.terraform_remote_state.global.outputs.lb_public_listener_arn_prod : data.terraform_remote_state.global.outputs.lb_public_listener_arn_test
}

data "aws_alb" "lb_public" {
  arn = var.meta == "prod" ?  data.terraform_remote_state.global.outputs.lb_public_arn_prod : data.terraform_remote_state.global.outputs.lb_public_arn_test
}