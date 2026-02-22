#!/bin/bash
yum update -y
amazon-linux-extras install java-openjdk11 -y
yum install -y git docker
systemctl enable docker
systemctl start docker