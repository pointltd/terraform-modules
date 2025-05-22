resource "aws_alb_target_group" "main" {
  for_each = local.listeners

  name = (
    each.value["use_hash_name"] ?
    md5(replace(each.key, "_", "-")) : replace(each.key, "_", "-")
  )

  vpc_id      = var.vpc_id
  target_type = "ip"
  protocol    = "HTTP"
  port        = each.value["port"]

  health_check {
    path                = each.value["health_check"]
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 10
    matcher             = "200-299"
  }

  tags = {
    Name = replace(each.key, "_", "-")
  }
}

resource "aws_lb_listener_rule" "main" {
  for_each = local.listeners_rules

  listener_arn = each.value["load_balancer_listener_arn"]

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main[each.key].arn
  }

  condition {
    host_header {
      values = each.value["host_headers"]
    }
  }

  condition {
    path_pattern {
      values = each.value["path_pattern"]
    }
  }
}