data "aws_alb_listener" "lb_public_listener" {
  arn = var.meta == "prod" ? data.terraform_remote_state.global.outputs.lb_public_listener_arn_prod : data.terraform_remote_state.global.outputs.lb_public_listener_arn_test
}

data "aws_alb" "alb_public" {
  id = var.meta == "prod" ?  data.terraform_remote_state.global.outputs.lb_public_prod_id : data.terraform_remote_state.global.outputs.lb_public_test_id
}