data "aws_route53_zone" "main" {
    zone_id = var.meta == "prod" ? data.terraform_remote_state.global.outputs.main_zone_id_prod : data.terraform_remote_state.global.outputs.main_zone_id_test
}

data "aws_route53_zone" "main_private" {
    zone_id = var.meta == "prod" ? data.terraform_remote_state.global.outputs.main_private_zone_id_prod : data.terraform_remote_state.global.outputs.main_private_zone_id_test
}