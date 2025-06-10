#!/bin/bash -xe

# Update system
sudo yum update -y
sudo yum upgrade -y

# Add Jenkins repo and install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Java 17 (Amazon Corretto), Jenkins, and start Jenkins
sudo yum install -y java-17-amazon-corretto jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# Install Git
sudo yum install -y git

# Install Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y terraform

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin
cp ./kubectl $HOME/bin/kubectl

# Add $HOME/bin to PATH for the current session
export PATH=$PATH:$HOME/bin

# Optionally add it to .bashrc for future sessions
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
