# Use the official OpenJDK image as the base image
FROM openjdk:21-jdk-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="1.21.10" \
    GEYSER_VERSION="2.7.0-SNAPSHOT-787" \
    FLOODGATE_VERSION="2.2.4-SNAPSHOT-28"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.21.10/0.17.3/1.1.0/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods
    
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/rhkWp6Ar/fabric-api-0.137.0%2B1.21.10.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/wKkoqHrH/versions/SM2rfos8/geyser-fabric-Geyser-Fabric-2.9.0-b979.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/QFAMeMNB/Floodgate-Fabric-2.2.6-b51.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/P1OZGk5p/versions/IZOlcyct/ViaVersion-5.5.2-SNAPSHOT.jar -O mods/viaversion.jar && \
    wget https://cdn.modrinth.com/data/NpvuJQoq/versions/n9RbDHMO/ViaBackwards-5.5.2-SNAPSHOT.jar -O mods/viabackwards.jar && \
    wget https://cdn.modrinth.com/data/YlKdE5VK/versions/kdVGOJPv/ViaFabric-0.4.20%2B126-main.jar -O mods/viafabric.jar

# Copy configuration files and start script
COPY server.properties ./
COPY geyser-config.yml ./
COPY floodgate-config.yml ./
COPY start.sh ./

# Make the start script executable
RUN chmod +x start.sh

# Expose server ports
EXPOSE 25565 24454/udp 19132/udp

# Start the server using the start.sh script
CMD ["./start.sh"]
