#!/bin/bash
set -xE
#yum remove -y java
#yum install -y java-1.8.0-openjdk wget
#wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
##sleep 1000
#rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#curl -LO 'https://rpmfind.net/linux/epel/7/x86_64/Packages/d/daemonize-1.7.7-1.el7.x86_64.rpm'
#rpm -Uvh ./daemonize-1.7.7-1.el7.x86_64.rpm
#yum install -y jenkins
#chkconfig jenkins on

yum install -y git
mkdir /var/lib/jenkins/.ssh
touch /var/lib/jenkins/.ssh/known_hosts
chown -R jenkins:jenkins /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
mv /tmp/id_rsa /var/lib/jenkins/.ssh/id_rsa
chmod 600 /var/lib/jenkins/.ssh/id_rsa
chown -R jenkins:jenkins /var/lib/jenkins/.ssh/id_rsa

mkdir -p /var/lib/jenkins/init.groovy.d
mv /tmp/*.groovy /var/lib/jenkins/init.groovy.d/
mv /tmp/jenkins /etc/sysconfig/jenkins
chmod +x /tmp/install-plugins.sh
bash /tmp/install-plugins.sh
service jenkins start
