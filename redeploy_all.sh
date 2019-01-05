#!/bin/bash

read -p "Stop and remove all docker containers? (y/N)"
[ "$REPLY" != "y" ] || (docker stop $(docker ps -a -q) \
    && sleep 5 \
    && docker rm $(docker ps -a -q) \
    && echo "Docker containers stopped and removed.")


read -p "Rebuild all EvaluEAT microservices? (y/N)"
[ "$REPLY" != "y" ] || (cd ../EvaluEAT && ./gradlew bootWar -Pdev jibDockerBuild \
    && cd ../EvaluEATgateway && ./gradlew bootWar -Pdev jibDockerBuild \
    && cd ../EvaluEATenvironment \
    && echo "Microservices rebuilt.")


read -p "Deploy full ecosystem? (y/N)"
[ "$REPLY" != "y" ] || (docker-compose up -d \
    && echo "Ecosystem should start in a few seconds...")