# Use the official OpenJDK image as the base image
FROM amd64v8/openjdk:21-jdk-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="1.21.5" \
    GEYSER_VERSION="2.7.0-SNAPSHOT-787" \
    FLOODGATE_VERSION="2.2.4-SNAPSHOT-28"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.21.5/0.16.13/1.0.3/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods
    
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/ZOyJh09R/fabric-api-0.120.0%2B1.21.5.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/wKkoqHrH/versions/qzYhEQza/geyser-fabric-Geyser-Fabric-2.7.0-b808.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/jb3lzved/Floodgate-Fabric-2.2.4-b42.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/P1OZGk5p/versions/FB1AZx0z/ViaVersion-5.2.1-SNAPSHOT.jar -O mods/viaversion.jar && \
    wget https://cdn.modrinth.com/data/NpvuJQoq/versions/cQfwR8Kg/ViaBackwards-5.2.1-SNAPSHOT.jar -O mods/viabackwards.jar && \
    wget https://cdn.modrinth.com/data/YlKdE5VK/versions/n9T0mzox/ViaFabric-0.4.18%2B104-main.jar -O mods/viafabric.jar && \
    wget https://cdn.modrinth.com/data/cl223EMc/versions/waCffck8/cristellib-fabric-2.0.2.jar -O mods/cristallib.jar && \
    wget https://cdn.modrinth.com/data/abooMhox/versions/NEuiaGve/treeharvester-1.21.5-9.1.jar -O mods/tree.jar && \
    wget https://cdn.modrinth.com/data/e0M1UDsY/versions/rSeksOK9/collective-1.21.5-8.2.jar -O mods/collective.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/ejJjBZIM/graves-3.7.1%2B1.21.5.jar -O mods/graves.jar && \
    wget https://cdn.modrinth.com/data/DjLobEOy/versions/HEqgNPcC/t_and_t-fabric-neoforge-1.13.5.jar -O mods/towns.jar && \
    wget https://cdn.modrinth.com/data/8oi3bsk5/versions/vGKEdR1w/Terralith_1.21.x_v2.5.9.jar -O mods/teralith.jar && \
    wget https://cdn.modrinth.com/data/TWsbC6jW/versions/S5p8KJxL/AdditionalStructures-1.21.5-%28v.6.2.0-NEO%29.jar -O mods/struc.jar 

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
