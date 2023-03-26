#!/bin/bash

# Define the name of the new Docker image
DOCKER_IMAGE_NAME=minecraft-server

# Define the name of the new Docker container
DOCKER_CONTAINER_NAME=minecraft-server

# Define the URLs of the configuration files
SERVER_PROPERTIES_URL=https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPOSITORY/main/server.properties
GEYSER_CONFIG_URL=hhttps://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/geyser-config.yml
FLOODGATE_CONFIG_URL=https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/floodgate-config.yml

# Download the configuration files
wget $SERVER_PROPERTIES_URL -O server.properties
wget $GEYSER_CONFIG_URL -O geyser-config.yml
wget $FLOODGATE_CONFIG_URL -O floodgate-config.yml

# Build the Docker image
docker build -t $DOCKER_IMAGE_NAME https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git#main

# Stop and remove the old Docker container (if it exists)
docker stop $DOCKER_CONTAINER_NAME
docker rm $DOCKER_CONTAINER_NAME

# Run the new Docker container
docker run -d \
  --name $DOCKER_CONTAINER_NAME \
  -p 25565:25565 -p 19132:19132/udp \
  -v $(pwd)/server.properties:/minecraft/server.properties \
  -v $(pwd)/geyser-config.yml:/minecraft/geyser-config.yml \
  -v $(pwd)/floodgate-config.yml:/minecraft/floodgate-config.yml \
  $DOCKER_IMAGE_NAME
