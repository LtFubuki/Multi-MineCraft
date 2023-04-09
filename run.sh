#!/bin/bash

# Define the name of the new Docker image
DOCKER_IMAGE_NAME=minecraft-server

# Define the name of the new Docker container
DOCKER_CONTAINER_NAME=minecraft-server

# Build the Docker image
docker build -t $DOCKER_IMAGE_NAME https://github.com/LtFubuki/Multi-MineCraft.git#main

# Stop and remove the old Docker container (if it exists)
docker stop $DOCKER_CONTAINER_NAME
docker rm $DOCKER_CONTAINER_NAME

# Download the configuration files and start script
wget https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/server.properties
wget https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/geyser-config.yml
wget https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/floodgate-config.yml
wget https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/start.sh
chmod +x start.sh

# Run the new Docker container
docker run -d \
  --name $DOCKER_CONTAINER_NAME \
  -p 25565:25565 \
  -p 19132:19132/udp \
  -v /minecraft:minecraft
  -v "$(pwd)/server.properties:/minecraft/server.properties" \
  -v "$(pwd)/geyser-config.yml:/minecraft/geyser-config.yml" \
  -v "$(pwd)/floodgate-config.yml:/minecraft/floodgate-config.yml" \
  -v "$(pwd)/start.sh:/minecraft/start.sh" \
  $DOCKER_IMAGE_NAME
