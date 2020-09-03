data "template_file" "install-jenkins" {
  template = "${file("${path.module}/install_jenkins.tpl")}"

  vars = {
    instance_name = "jenkins"
  }
}

resource "aws_efs_file_system" "jenkins-fs" {
  depends_on     = [ var.jenkins-sg-id ]
  creation_token = "jenkins"
  encrypted      = true

  tags = {
    Name = "Jenkins-EFS"
  }
}

resource "aws_efs_mount_target" "mount-jenkins" {
  depends_on       = [ aws_efs_file_system.jenkins-fs, ]
   file_system_id  = aws_efs_file_system.jenkins-fs.id
   subnet_id       = "${var.eu-central-1a-infra-subnet-id}"
   security_groups = ["${var.jenkins-sg-id}"]
}

resource "aws_efs_access_point" "jenkins" {
  file_system_id = aws_efs_file_system.jenkins-fs.id
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
