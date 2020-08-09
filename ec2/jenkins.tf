data "template_file" "install-jenkins" {
  template = "${file("${path.module}/install_jenkins.tpl")}"

  vars = {
    instance_name = "jenkins"
  }
}

resource "aws_instance" "jenkins" {
  ami                  = "${var.ami}"
  instance_type        = "t2.micro"

  tags = {
    Name   = "jenkins"
  }

  subnet_id                   = "${var.eu-central-1a-infra-subnet-id}"
  key_name                    = "degree-key"
  associate_public_ip_address = "true"
  disable_api_termination     = "true"
  user_data                   = "${data.template_file.install-jenkins.rendered}"

  vpc_security_group_ids = ["${var.jenkins-sg-id}"]
}

output "jenkins-ip" {
  value = "${aws_instance.jenkins.private_ip}"
}
