# Use the official OpenJDK image as the base image
FROM openjdk:8-alpine

# Set environment variables
ENV MINECRAFT_VERSION="1.17.1" \
    GEYSER_VERSION="2.0.0-SNAPSHOT" \
    FLOODGATE_VERSION="2.0"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

# Download GeyserMC and Floodgate
RUN wget https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/standalone/target/Geyser-standalone-${GEYSER_VERSION}.jar -O Geyser.jar && \
    wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/development/lastSuccessfulBuild/artifact/bukkit/target/floodgate-bukkit-${FLOODGATE_VERSION}.jar -O Floodgate.jar

# Copy configuration files
COPY server.properties ./
COPY geyser-config.yml ./
COPY floodgate-config.yml ./

# Expose server ports
EXPOSE 25565 19132/udp

# Start the server
CMD ["java", "-Xmx2G", "-jar", "minecraft_server.jar", "--nogui"]
