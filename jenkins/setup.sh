#!/bin/bash
set -xE
echo "Install Jenkins stable release"
#yum remove yum-updatesd
yum remove -y java
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#curl -LO 'https://rpmfind.net/linux/epel/7/x86_64/Packages/d/daemonize-1.7.7-1.el7.x86_64.rpm'
#rpm -Uvh ./daemonize-1.7.7-1.el7.x86_64.rpm
yum upgrade
yum install -y java-11-openjdk-devel wget epel-release
yum install -y jenkins
chkconfig jenkins on
#service jenkins start