#!/bin/sh

set -x

script_log="/var/log/tf-user-data_`date +%F`.log"
exec 1>>$script_log
exec 2>&1

set_hostname=${set_hostname}

private_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
#public_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

az=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
coast=`echo $${az:3:1} | tr '[:upper:]' '[:lower:]'`

az_rev=`echo $${az} | rev`
zone=$${az_rev:0:1}

inst="`curl -s http://169.254.169.254/latest/meta-data/instance-id || die \"wget instance-id has failed: $?\"`"

{*node_name="${environment}-$${inst}"*}
node_name="$${inst}"

if [ "$set_hostname" == "true" ] ; then
sudo hostnamectl set-hostname $node_name
fi

sudo yum update -y
sudo yum -y install wget unzip python3
sudo yum install java-1.8.0-openjdk git -y
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install django djangorestframework
python3 -m pip install boto3 botocore requests dnspython psycopg2-binary

sudo curl -L --output /usr/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"
sudo chmod +x /usr/bin/gitlab-runner
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

/usr/local/bin/aws ec2 create-tags --resources $inst --tags Key=Name,Value=$node_name
/usr/local/bin/aws ec2 create-tags --resources $inst --tags Key=PubIp,Value=$public_ip

/usr/local/bin/aws s3api get-object --bucket tools --key sumologic/sumo_install.py sumo_install.py
/usr/local/bin/aws s3api get-object --bucket tools --key sumologic/linux_source.json linux_source.json


python3 sumo_install.py
