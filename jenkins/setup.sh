#!/bin/bash
set -x
echo "Install Jenkins stable release"
#yum remove yum-updatesd
yum remove -y java
yum install -y java-1.8.0-openjdk wget
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
#sleep 1000
rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
curl -LO 'https://rpmfind.net/linux/epel/7/x86_64/Packages/d/daemonize-1.7.7-1.el7.x86_64.rpm'
rpm -Uvh ./daemonize-1.7.7-1.el7.x86_64.rpm
yum install -y jenkins
chkconfig jenkins on
service jenkins start