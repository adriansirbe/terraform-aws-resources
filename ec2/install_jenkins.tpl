#!/bin/bash
sudo yum install epel-release -y
sudo yum update -y && sudo yum upgrade -y
sudo yum install wget curl unzip java-1.8.0-openjdk git openssh-clients -y
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload
