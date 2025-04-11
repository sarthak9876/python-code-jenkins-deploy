#!/bin/bash
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo yum install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo yum install python -y
sudo yum install git -y
sudo yum install curl -y
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins
sudo systemctl restart docker
sudo systemctl restart jenkins
