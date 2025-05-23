data "aws_rds_cluster" "partha" {
  cluster_identifier = var.meta == "prod" ? data.terraform_remote_state.global.outputs.partha_cluster_identifier_prod : data.terraform_remote_state.global.outputs.partha_cluster_identifier_test
}

data "aws_secretsmanager_secret_version" "partha_db_secret" {
  secret_id = data.aws_rds_cluster.partha.master_user_secret[0].secret_arn
}
