# #!/bin/bash -xe

# # Update system
# sudo yum update -y
# sudo yum upgrade -y

# # Add Jenkins repo and install Jenkins
# sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# # Install Java 17 (Amazon Corretto), Jenkins, and start Jenkins
# sudo yum install -y java-17-amazon-corretto jenkins
# sudo systemctl enable jenkins
# sudo systemctl start jenkins
# sudo systemctl status jenkins

# # Install Git
# sudo yum install -y git

# # Install Terraform
# sudo yum install -y yum-utils
# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
# sudo yum install -y terraform

# # Install kubectl
# curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
# chmod +x ./kubectl
# mkdir -p $HOME/bin
# cp ./kubectl $HOME/bin/kubectl

# # Add $HOME/bin to PATH for the current session
# export PATH=$PATH:$HOME/bin

# # Optionally add it to .bashrc for future sessions
# echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc




#!/bin/bash -xe

# Update system
sudo yum update -y
sudo yum upgrade -y

# Add Jenkins repo and import GPG key
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install latest Jenkins and Java 21 (Amazon Corretto)
sudo yum install -y java-21-amazon-corretto jenkins

# Start and enable Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Optional: Check Jenkins status (will not fail script)
sudo systemctl status jenkins || true

# Install Git
sudo yum install -y git

# Install Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y terraform

# Install latest kubectl (v1.29.2 as of June 2025)
KUBECTL_VERSION="v1.29.2"
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mkdir -p $HOME/bin
mv ./kubectl $HOME/bin/kubectl

# Ensure kubectl is available in current and future sessions
export PATH="$HOME/bin:$PATH"
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc


# # Wait for Jenkins to be up (optional)
# sleep 30
# curl -s http://localhost:8080 || echo "Jenkins may still be starting..."

