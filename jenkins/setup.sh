#!/bin/bash
set -xE

echo "Install Jenkins stable release"
yum remove -y java
yum install -y java-11-openjdk

echo "Install git"
yum install -y git
