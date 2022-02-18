resource "aws_security_group" "security_group" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port  = ingress.value.from
      to_port = ingress.value.to
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules

    content {
      from_port  = egress.value.from
      to_port = egress.value.to
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr
    }
  }

   tags = merge(
          var.tags,
          {
            Name = "sg-${var.environment}-${var.application_name}"
          },
  )
  tags = {
    Name = var.name
  }
}


