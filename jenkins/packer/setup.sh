#!/bin/bash
set -xE

echo "Install Jenkins stable release"
yum remove -y java
#yum install -y java-1.8.0-openjdk
yum install -y java-11-amazon-corretto

echo "Install git"
yum install -y git
