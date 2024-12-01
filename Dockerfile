# Use the official OpenJDK image as the base image
FROM arm64v8/openjdk:21-jdk-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="1.21.3" \
    GEYSER_VERSION="2.5.0-SNAPSHOT-588" \
    FLOODGATE_VERSION="2.2.4-SNAPSHOT-28"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.21.3/0.16.9/1.0.1/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods
    
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/bQzqZbjS/fabric-api-0.110.0%2B1.21.3.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/wKkoqHrH/versions/9I48F8gS/geyser-fabric-Geyser-Fabric-2.5.0-b721.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/fi1OaueM/Floodgate-Fabric-2.2.4-b39.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/P1OZGk5p/versions/Lli49VrJ/ViaVersion-5.1.2-SNAPSHOT.jar -O mods/viaversion.jar && \
    wget https://cdn.modrinth.com/data/NpvuJQoq/versions/H28iNR9D/ViaBackwards-5.1.2-SNAPSHOT.jar -O mods/viabackwards.jar && \
    wget https://cdn.modrinth.com/data/YlKdE5VK/versions/CQ7NwggR/ViaFabric-0.4.16%2B88-main.jar -O mods/viafabric.jar

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
