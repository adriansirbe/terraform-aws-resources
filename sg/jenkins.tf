resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Security group for jenkins server"
  vpc_id      = "${var.infra-vpc-id}"

  tags ={
    Name = "jenkins-sg"
  }
}

resource "aws_security_group_rule" "jenkins-ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.jenkins-sg.id}"
}

resource "aws_security_group_rule" "jenkins-http" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.jenkins-sg.id}"
}

resource "aws_security_group_rule" "jenkins-internet-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.jenkins-sg.id}"
}

output "jenkins-sg-id" {
  value = "${aws_security_group.jenkins-sg.id}"
}