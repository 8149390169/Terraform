#!/bin/bash 

echo "---------------- set hostname ----------------"
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//')
INSTID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
NAME=$(aws ec2 describe-instances --filters Name=instance-id,Values=$INSTID  --query 'Reservations[].Instances[].Tags[?Key==`Name`].Value[]' --output text --region=$REGION)
SNAME=$(echo $NAME | awk -F. '{print $1}')

logger "Cloud-init: set hostname $NAME"

echo  "$NAME" > /etc/hostname
hostnamectl set-hostname $NAME

logger "Cloud-init: add hosts entry $IP $NAME $SNAME"
[[ `grep $NAME /etc/hosts` ]] ||  echo -e "$IP\t$NAME\t$SNAME" >> /etc/hosts

# disable firewall
systemctl stop firewalld
systemctl disable firewalld

# disable selinux
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

GIT_USR=shubham.bhadke
GIT_PSW=Sonyalph%407m3
GIT_URL=github.globant.com/shubham-bhadke/Chef.git
CHEF_URL=https://omnitruck.chef.io/install.sh
CHEF_VERSION=0.18.30

echo "---------------- yum update latest ----------------"
/usr/bin/yum clean all
yum update -y
echo "---------------- Installing basic packages ----------------"
yum install git -y
yum -y install python3-pip 
pip3 install awscli

echo "---------------- Chef installing ----------------"
curl ${CHEF_URL} | sudo bash -s -- -P chefdk -c stable -v ${CHEF_VERSION}
mkdir /root/cookbooks/
echo "---------------- Chef Genrating cookbook ----------------"
chef generate cookbook /root/cookbooks/apache
echo "---------------- Chef Cloning ----------------"
cd /tmp/
git clone "https://${GIT_USR}:${GIT_PSW}@${GIT_URL}" 
cp -rvf /tmp/Chef/apache/server.rb /root/cookbooks/apache/recipes/
echo "---------------- Chef Config applying ----------------"
chef-client -z /root/cookbooks/apache/recipes/server.rb
echo "---------------- Removing tem data ----------------"
rm -rf /tmp/Chef
