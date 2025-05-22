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