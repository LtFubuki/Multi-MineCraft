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
RUN wget https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

# Download GeyserMC and Floodgate
RUN wget https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/standalone/build/libs/Geyser-Standalone.jar -O Geyser.jar && \
    wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/build/libs/floodgate-spigot.jar -O Floodgate.jar

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
