# Use the official OpenJDK image as the base image
FROM openjdk:22-jdk-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="1.21.10" \
    GEYSER_VERSION="2.7.0-SNAPSHOT-787" \
    FLOODGATE_VERSION="2.2.4-SNAPSHOT-28"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.21.11/0.18.3/1.1.0/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods
    
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/gB6TkYEJ/fabric-api-0.140.2%2B1.21.11.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/wKkoqHrH/versions/rPAhdfqh/geyser-fabric-Geyser-Fabric-2.9.2-b1013.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/wzwExuYr/Floodgate-Fabric-2.2.6-b54.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/Fb4jn8m6/versions/hDjB8uAg/FallingTree-1.21.10-1.21.10.1.jar -O mods/fallingtree.jar && \
    wget https://cdn.modrinth.com/data/gqRXDo8B/versions/PlzaDKOA/villagernames-1.21.10-8.3.jar -O mods/villigarnames.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/bJROTlRS/graves-3.9.0%2B1.21.9.jar -O mods/graves.jar && \
    wget https://cdn.modrinth.com/data/5ibSyLAz/versions/FX9V1bWK/inventorysorter-fabric-2.1.0%2Bmc1.21.9.jar -O mods/sorting.jar && \
    wget https://cdn.modrinth.com/data/9s6osm5g/versions/qMxkrrmq/cloth-config-20.0.149-fabric.jar -O mods/clothconfig.jar && \
    wget https://cdn.modrinth.com/data/P7dR8mSH/versions/dQ3p80zK/fabric-api-0.138.3%2B1.21.10.jar -O mods/fabricapi.jar
    
    
    
    
    
    
    
    
    
    
    

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
