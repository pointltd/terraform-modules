locals {
  name = "${var.name}-${var.environment}"

  elasticache_node_type = {
    test = "cache.t3.micro"
    prod = "cache.t3.medium"
  }
}