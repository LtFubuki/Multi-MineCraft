#!/bin/bash

# Define the name of the new Docker image
DOCKER_IMAGE_NAME=minecraft-server

# Define the name of the new Docker container
DOCKER_CONTAINER_NAME=minecraft-server

build_docker_image() {
  if docker build -t $DOCKER_IMAGE_NAME https://github.com/LtFubuki/Multi-MineCraft.git#main; then
    echo "Docker image built successfully."
  else
    echo "Error building Docker image. Exiting."
    exit 1
  fi
}

stop_and_remove_old_container() {
  if docker inspect $DOCKER_CONTAINER_NAME &>/dev/null; then
    if docker stop $DOCKER_CONTAINER_NAME && docker rm $DOCKER_CONTAINER_NAME; then
      echo "Old Docker container stopped and removed."
    else
      echo "Error stopping and removing old Docker container. Exiting."
    fi
  else
    echo "No existing Docker container found."
  fi
}

download_configuration_files_and_start_script() {
  if wget https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/server.properties \
    && wget https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/geyser-config.yml \
    && wget https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/floodgate-config.yml \
    && wget https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/start.sh; then
    chmod +x start.sh
    echo "Configuration files and start script downloaded successfully."
  else
    echo "Error downloading configuration files or start script. Exiting."
    exit 1
  fi
}

run_docker_container() {
  if docker run -d \
    --name $DOCKER_CONTAINER_NAME \
    -p 25565:25565 \
    -p 8123:8123 \
    -p 19132:19132/udp \
    -v "multi-minecraft:/minecraft" \
    -v "$(pwd)/server.properties:/minecraft/server.properties" \
    -v "$(pwd)/geyser-config.yml:/minecraft/geyser-config.yml" \
    -v "$(pwd)/floodgate-config.yml:/minecraft/floodgate-config.yml" \
    -v "$(pwd)/start.sh:/minecraft/start.sh" \
    $DOCKER_IMAGE_NAME; then
    echo "Docker container started successfully."
  else
    echo "Error starting Docker container. Exiting."
    exit 1
  fi
}

main() {
  build_docker_image
  stop_and_remove_old_container
  download_configuration_files_and_start_script
  run_docker_container
}

main
