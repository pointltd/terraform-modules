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