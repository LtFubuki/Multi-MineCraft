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

```bash
curl -s https://raw.githubusercontent.com/LtFubuki/Multi-MineCraft/main/run.sh | bash
```
