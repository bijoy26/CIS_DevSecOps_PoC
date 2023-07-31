#!/bin/bash
DOCKERFILE_PATH=/home/cseju/cis-demo-tools/VulnerableDockerfile/vulnContainer/Dockerfile
USER=bijoy26
IMAGE=ubuntu_nodejs
IMAGE_TAG=v3
OUTPUT_DIR=/home/cseju/cis-demo-tools/reports
DOCKERHUB_USER=bijoy26

# Regular Colors
Black='\033[0;30m'  # Black
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan
White='\033[0;37m'  # White
NC='\033[0m'        # No Color

## git pull here ##
## static analyzer here ##

# login to docker registry (set $DOCKER_PASS in .bashrc)
# echo $DOCKER_PASS | docker login -u ${DOCKERHUB_USER} --password-stdin
echo -e "\n        ${Cyan}###### STATIC ANALYZER ENGINE #######${NC}"
sleep 1
# base image recommendations
echo -e "\n        ${Yellow} ⭐ EXECUTING BASE IMAGE CHECKER ⭐ ${NC}"
unbuffer docker scout recommendations ${USER}/${IMAGE}:${IMAGE_TAG} | tee ${OUTPUT_DIR}/base_image_fix_${USER}_${IMAGE}_${IMAGE_TAG}.txt >/dev/null 2>&1 &
sleep 1
echo -e "\n        ${Green} ✅ BASE IMAGE CHECKER PROCESS SENT TO BACKGROUND ✅'${NC}"

# Dockerfile recommendations
echo -e "\n        ${Yellow} ⭐ EXECUTING Dockerfile CHECKER ⭐ ${NC}"
unbuffer trivy -q conf ${DOCKERFILE_PATH} | tee ${OUTPUT_DIR}/dockerfile_fix_vulncont.txt >/dev/null 2>&1
echo -e "\n        ${Green} ✅ Dockerfile Fix Report Generated ✅'${NC}"
## falco stuff here ##