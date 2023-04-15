# Multi-MineCraft Docker

This repository contains a Dockerfile and a setup script for deploying a Minecraft server with several mods, GeyserMC, and Floodgate. The server allows both Java and Bedrock Edition players to join.

## Prerequisites

Docker installed on your system
Basic knowledge of Docker and the command line

## Getting Started

Clone this repository to your local machine:

```bash
git clone https://github.com/LtFubuki/Multi-MineCraft.git
```

Change to the repository directory:

```bash
cd Multi-MineCraft
```

Run the setup script:

```bash
chmod +x setup.sh \
./setup.sh
```

One liner setup:

```bash
curl -s https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/run.sh | bash
```


This script will build the Docker image, remove any existing containers with the same name, download configuration files and the start script, and finally run a new Docker container with the Minecraft server.
If you encounter any errors, make sure you have Docker installed and running, and that you have the necessary permissions to execute the script.


## Ports

By default, the following ports are exposed:

25565: Minecraft Java Edition
8123: Dynmap web server
19132: Minecraft Bedrock Edition (UDP)
Make sure these ports are properly forwarded if you are running the server behind a router or firewall.


## Customizing the Server

You can customize the server by editing the configuration files located in the repository directory:

server.properties: Minecraft server configuration
geyser-config.yml: GeyserMC configuration
floodgate-config.yml: Floodgate configuration
You can also customize the mods and their versions by editing the Dockerfile. Simply change the URLs and filenames for the mods you want to add or remove.

After making changes to the configuration files or the Dockerfile, rebuild the image and restart the container by running the ./setup.sh script again.


## Updating the Server

To update the server, edit the Dockerfile and change the MINECRAFT_VERSION, GEYSER_VERSION, and FLOODGATE_VERSION environment variables to the desired version numbers. Then, run the ./setup.sh script to rebuild the image and restart the container.

Warning: Updating the server may cause compatibility issues with existing worlds, plugins, or mods. Always create a backup of your server data before updating.


## Acknowledgments

GeyserMC and Floodgate for enabling cross-platform play
All mod creators for their hard work and dedication to the Minecraft community
The OpenJDK team for providing a lightweight and efficient Java runtime environment
Docker for simplifying deployment and management of applications


# Further explanation of files

## Dockerfile

The Dockerfile is used to create a Docker image for a Minecraft server with several mods, GeyserMC, and Floodgate. It is based on the official OpenJDK 17 Alpine image. Here is a breakdown of the Dockerfile:

It uses the official OpenJDK 17 Alpine image as the base image.
Sets environment variables for Minecraft, Geyser, and Floodgate versions.
Creates and set the working directory to /minecraft.
Downloads the Minecraft server JAR file and accept the EULA by creating an eula.txt file with the content eula=true.
Creates a mods directory and download various mods into it.
Downloads GeyserMC and Floodgate JAR files and place them in the mods directory.
Copies the configuration files and the start script into the working directory.
Makes the start script executable using chmod +x.
Exposes the server ports: 25565 (Minecraft), 8123 (Dynmap web server), and 19132 (Bedrock Edition UDP port).
Defines the start command to run the start.sh script.

Once this Dockerfile is used to build an image, the image will contain a Minecraft server with the specified mods, GeyserMC, and Floodgate, along with the necessary configuration files and start script. 
The server can be run by creating a Docker container from the image and exposing the necessary ports.


## 

The Bash script that automates the process of setting up a Minecraft server using Docker. It does the following:

Defines the name of the new Docker image and container.
Builds the Docker image from the specified GitHub repository.
Stops and removes the old Docker container if it exists.
Downloads the necessary configuration files and start script for the Minecraft server.
Runs the new Docker container with the appropriate settings and port mappings.

Here's a step-by-step explanation of the script:

Set the Docker image and container name variables.
Define the build_docker_image function that builds the Docker image from the given GitHub repository. If successful, print a message; otherwise, print an error message and exit the script with exit code 1.
Define the stop_and_remove_old_container function that checks if a Docker container with the specified name exists. If it does, stop and remove it. If successful, print a message; otherwise, print an error message and exit the script with exit code 1.
Define the download_configuration_files_and_start_script function that downloads the necessary configuration files and start script for the Minecraft server. If successful, set executable permissions for the start script and print a message; otherwise, print an error message and exit the script with exit code 1.
Define the run_docker_container function that runs the Docker container with the appropriate settings and port mappings. If successful, print a message; otherwise, print an error message and exit the script with exit code 1.
Define the main function that calls the previously defined functions in the correct order.
Call the main function to start the script.
This script assumes that Docker is installed on the system and that the user has the appropriate permissions to run Docker commands.





