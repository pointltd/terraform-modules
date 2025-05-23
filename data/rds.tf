data "aws_rds_cluster" "partha" {
    cluster_identifier = var.meta == "prod" ?  data.terraform_remote_state.global.outputs.cluster_identifier_prod : data.terraform_remote_state.global.outputs.cluster_identifier_test
}