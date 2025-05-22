locals {
  listeners = merge([
    for service_key, service in var.services : {
      for container_name, listener in service.listeners :
      "${service_key}-${container_name}-${var.meta.environment}" => {
        port                            = listener.port
        health_check                    = listener.health_check
        use_hash_name = lookup(listener, "use_hash_name", false)
        load_balancer_listener_arn      = listener.load_balancer_listener_arn
        load_balancer_security_group_id = listener.load_balancer_security_group_id
        rules                           = [
          for rule in listener.rules : {
            name         = rule.name
            priority     = rule.priority
            host_headers = rule.host_headers
            path_pattern = rule.path_pattern
          }
        ]
      }
    }
  ]...)

  listeners_rules = merge([
    for service_key, service in var.services : {
      for container_name, listener in service.listeners :
      "${service_key}-${container_name}-${var.meta.environment}" => {
        load_balancer_listener_arn = listener.load_balancer_listener_arn
        host_headers = flatten([for rule in listener.rules : rule.host_headers])
        path_pattern = flatten([for rule in listener.rules : rule.path_pattern])
      }
    }
  ]...)
}