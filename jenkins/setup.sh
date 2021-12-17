#!/bin/bash
set -xE

echo "Install Jenkins stable release"
yum remove -y java
yum install -y java-1.8.0-openjdk

echo "Install git"
yum install -y git
