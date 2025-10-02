resource "aws_vpc" "vpc_id" {
 cidr_block = var.vpc_cidr_block
 tags = var.tags
}

resource "aws_flow_log" "vpc_flow_log" {
  count = var.enable_flow_log ? 1 : 0

  vpc_id               = aws_vpc.vpc_id.id
  log_destination      = var.flow_log_log_destination
  log_destination_type = var.flow_log_destination_type
  traffic_type         = var.flow_log_traffic_type

  tags = merge(
    var.tags,
    {
      Name = "rm-${var.domain}-flow-log"
    }
  )
}

