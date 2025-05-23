variable "region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "meta" {
  type = object({
    name        = string
    environment = string
  })

  validation {
    condition     = contains(["test", "prod"], var.meta.environment)
    error_message = "Meta environment must be one of \"test\" or \"prod\"."
  }
}

variable "tasks" {
  type = map(object({
    # cpu    = number
    # memory = number
    containers = list(object({
      name      = string
      image_tag = string
      # command            = list(string)
      ports = list(number)
      # environment_files  = list(string)
      environment = map(string)
      essential   = bool
      # secrets            = map(string)
      # mount_points       = map(string)
    }))
  }))
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "The ARN of the ECS task execution role."
}

variable "ecs_task_role_arn" {
  type        = string
  description = "The ARN of the ECS task role."
}
