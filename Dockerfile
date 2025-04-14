# Use the official OpenJDK image as the base image
FROM arm64v8/openjdk:21-jdk-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="1.21.4" \
    GEYSER_VERSION="2.7.0-SNAPSHOT-787" \
    FLOODGATE_VERSION="2.2.4-SNAPSHOT-28"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.21.4/0.16.9/1.0.1/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods
    
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/15ijyoD6/fabric-api-0.113.0%2B1.21.4.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/wKkoqHrH/versions/qzYhEQza/geyser-fabric-Geyser-Fabric-2.7.0-b808.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/jb3lzved/Floodgate-Fabric-2.2.4-b42.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/P1OZGk5p/versions/FB1AZx0z/ViaVersion-5.2.1-SNAPSHOT.jar -O mods/viaversion.jar && \
    wget https://cdn.modrinth.com/data/NpvuJQoq/versions/cQfwR8Kg/ViaBackwards-5.2.1-SNAPSHOT.jar -O mods/viabackwards.jar && \
    wget https://cdn.modrinth.com/data/YlKdE5VK/versions/YVYkific/ViaFabric-0.4.17%2B102-main.jar -O mods/viafabric.jar && \
    wget https://cdn.modrinth.com/data/cl223EMc/versions/Z4HqO4Am/cristellib-fabric-1.2.10.jar -O mods/cristallib.jar && \
    wget https://cdn.modrinth.com/data/abooMhox/versions/klxo2KdO/treeharvester-1.21.4-9.0.jar -O mods/tree.jar && \
    wget https://cdn.modrinth.com/data/e0M1UDsY/versions/F3ciVO4i/collective-1.21.4-7.89.jar -O mods/collective.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/o2f2Idvu/graves-3.6.0%2B1.21.4.jar -O mods/graves.jar && \
    wget https://cdn.modrinth.com/data/DjLobEOy/versions/wF6xyXMX/t_and_t-fabric-neoforge-1.13.3.jar -O mods/towns.jar && \
    wget https://cdn.modrinth.com/data/8oi3bsk5/versions/lQreFvOm/Terralith_1.21.x_v2.5.7.jar -O mods/teralith.jar && \
    wget https://cdn.modrinth.com/data/TWsbC6jW/versions/35Xcs8k8/AdditionalStructures-1.21.x-%28v.5.0.1-fabric%29.jar -O mods/struc.jar 

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
