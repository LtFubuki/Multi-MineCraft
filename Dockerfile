# Use the official OpenJDK image as the base image
FROM openjdk:16-alpine

# Set environment variables
ENV MINECRAFT_VERSION="1.19.4" \
    GEYSER_VERSION="2.0.0-SNAPSHOT" \
    FLOODGATE_VERSION="2.0"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

# Download GeyserMC and Floodgate
RUN wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot -O Geyser.jar && \
    wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/build/libs/floodgate-spigot.jar -O Floodgate.jar

# Copy configuration files
COPY server.properties ./
COPY geyser-config.yml ./
COPY floodgate-config.yml ./

# Expose server ports
EXPOSE 25565 19132/udp

# Start the server
CMD ["java", "-Xmx2G", "-jar", "minecraft_server.jar", "--nogui"]
