# Use the official OpenJDK image as the base image
FROM openjdk:17-alpine

# Set environment variables
ENV MINECRAFT_VERSION="1.19.4" \
    GEYSER_VERSION="2.0.0-SNAPSHOT" \
    FLOODGATE_VERSION="2.0"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.19.4/0.14.19/0.11.2/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods && \
    wget https://mediafilez.forgecdn.net/files/4474/468/fabric-api-0.77.0%2B1.19.4.jar -O mods/fabric_api.jar && \
    wget https://mediafilez.forgecdn.net/files/4466/959/fabric-language-kotlin-1.9.3%2Bkotlin.1.8.20.jar -O mods/fabric_kotlin.jar && \
    wget https://mediafilez.forgecdn.net/files/4440/461/cloth-config-10.0.96-forge.jar -O cloth_config.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/vHvEE5VR/graves-2.2.1%2B1.19.4.jar -O mods/graves.jar && \
    wget https://cdn-raw.modrinth.com/data/fRQREgAc/versions/jHY0XK3D/Dynmap-3.5-beta-3-fabric-1.19.4.jar -O mods/dyn_map.jar && \
    wget https://cdn.modrinth.com/data/PTGd6dWp/versions/ZlwA2G0d/mostructures-1.4.3%2B1.19.4.jar -O mods/mo_structures.jar

# Download GeyserMC and Floodgate
RUN wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/fabric -O mods/Geyser.jar && \
    wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate-Fabric/job/master/lastSuccessfulBuild/artifact/build/libs/floodgate-fabric.jar -O mods/Floodgate.jar

# Copy configuration files and start script
COPY server.properties ./
COPY geyser-config.yml ./
COPY floodgate-config.yml ./
COPY start.sh ./

# Make the start script executable
RUN chmod +x start.sh

# Expose server ports
EXPOSE 25565 19132/udp

# Start the server using the start.sh script
CMD ["./start.sh"]
