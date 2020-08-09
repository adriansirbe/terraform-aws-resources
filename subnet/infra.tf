resource "aws_subnet" "eu-central-1a-infra" {
  vpc_id            = "${var.infra-vpc-id}"
  cidr_block        = "10.0.1.0/26"
  availability_zone = "eu-central-1a"

  tags = {
    Name            = "eu-central-1a-infra"
  }
}

output "eu-central-1a-infra-subnet-id" {
  value = "${aws_subnet.eu-central-1a-infra.id}"
}

output "eu-central-1a-infra-subnet-cidr-block" {
  value = "${aws_subnet.eu-central-1a-infra.cidr_block}"
}
