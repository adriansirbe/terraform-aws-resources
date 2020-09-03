#!/bin/bash
sudo yum install epel-release -y
sudo yum update -y && sudo yum upgrade -y
sudo yum install wget curl unzip java-1.8.0-openjdk git openssh-clients amazon-efs-utils -y
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo mkdir /mount
sudo mount -t efs -o tls,accesspoint=fsap-0181822d5541a349c fs-dc711384:/ /mount
sudo mkdir /var/lib/jenkins
sudo cp -p -r /mount/* /var/lib/jenkins/
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload
