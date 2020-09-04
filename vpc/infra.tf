resource "aws_vpc" "infra" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    "Name" = "infra"
  }
}

resource "aws_internet_gateway" "infra" {
    vpc_id = aws_vpc.infra.id

    tags = {
        Name = "infra"
    }
}

resource "aws_route_table" "infra" {
    vpc_id = aws_vpc.infra.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.infra.id
    }
    tags = {
        Name = "infra"
    }
}

resource "aws_route_table_association" "a" {
  subnet_id      = var.eu-central-1a-infra-subnet-id
  route_table_id = aws_route_table.infra.id
}

output "vpc-id" {
  value = "${aws_vpc.infra.id}"
}

output "vpc-cidr-block" {
  value = "${aws_vpc.infra.cidr_block}"
}
