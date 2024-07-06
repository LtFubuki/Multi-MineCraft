# Use the official OpenJDK image as the base image
FROM arm64v8/openjdk:21-jdk-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="1.21" \
    GEYSER_VERSION="2.4.0-SNAPSHOT-588" \
    FLOODGATE_VERSION="2.2.3-SNAPSHOT-28"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.21/0.15.11/1.0.1/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods && \
    wget https://cdn.modrinth.com/data/P7dR8mSH/versions/oIVA3FbL/fabric-api-0.100.4%2B1.21.jar -O mods/fabric_api.jar && \
    wget https://mediafilez.forgecdn.net/files/5500/955/voicechat-fabric-1.21-2.5.18.jar -O mods/voicechat.jar
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/wKkoqHrH/versions/roQJJk43/geyser-fabric-2.4.0-SNAPSHOT%2Bbuild.588.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/D4KXqjtC/Floodgate-Fabric-2.2.3-SNAPSHOT%2Bbuild.28.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/P1OZGk5p/versions/fojFzCyd/ViaVersion-5.0.2-SNAPSHOT.jar -O mods/viaversion.jar && \
    wget https://cdn.modrinth.com/data/NpvuJQoq/versions/HP0St2QS/ViaBackwards-5.0.2-SNAPSHOT.jar -O mods/viabackwards.jar && \
    wget https://cdn.modrinth.com/data/YlKdE5VK/versions/Tw6VYjjI/ViaFabric-0.4.14%2B74-main.jar -O mods/viafabric.jar

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
