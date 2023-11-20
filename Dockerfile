# Use the official OpenJDK image as the base image
FROM arm64v8/openjdk:17-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="1.20.2" \
    GEYSER_VERSION="2.0.0-SNAPSHOT" \
    FLOODGATE_VERSION="2.0"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.20.2/0.14.24/0.11.2/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods && \
    wget https://cdn.modrinth.com/data/P7dR8mSH/versions/FhOnpSMY/fabric-api-0.90.7%2B1.20.2.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/TWsbC6jW/versions/4aO595R4/AdditionalStructures-1.20.x-%28v.4.2.1%29.jar -O mods/add_strucs.jar && \
    wget https://cdn.modrinth.com/data/egyqODDj/versions/t2PB8GHU/spellbound-weapons-v4.0.5g.jar -O mods/bound_wepons.jar
    
# Download GeyserMC and Floodgate
RUN wget https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/fabric/build/libs/Geyser-Fabric.jar -O mods/Geyser.jar && \
    wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate-Fabric/job/master/lastSuccessfulBuild/artifact/build/libs/floodgate-fabric.jar -O mods/Floodgate.jar

# Copy configuration files and start script
COPY server.properties ./
COPY geyser-config.yml ./
COPY floodgate-config.yml ./
COPY start.sh ./

# Make the start script executable
RUN chmod +x start.sh

# Expose server ports
EXPOSE 25565 8123 19132/udp

# Start the server using the start.sh script
CMD ["./start.sh"]
