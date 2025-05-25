variable "vpc_id" {
  type = string
}

variable "cluster_id" {
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

variable "services" {
  type = map(object({
    name                = string
    task_definition_arn = string
    subnets             = list(string)
    security_groups     = list(string)
    listeners = map(object({
      port          = number
      health_check  = string
      use_hash_name = optional(bool, false)
      load_balancer_listener_arn = string
      load_balancer_security_group_id = string,
      rules = list(object({
        name         = string
        priority     = number
        host_headers = list(string)
        path_pattern = string
      }))
    }))
  }))
}

