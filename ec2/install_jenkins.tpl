#!/bin/bash
yum install epel-release -y
yum update -y && sudo yum upgrade -y
yum install wget curl unzip java-1.8.0-openjdk git openssh-clients amazon-efs-utils -y
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
mkdir /mount
mount -t efs -o tls,accesspoint=fsap-0181822d5541a349c fs-dc711384:/ /mount
mkdir /var/lib/jenkins
cp -p -r /mount/* /var/lib/jenkins/
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload
