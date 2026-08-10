# Use the official OpenJDK image as the base image
FROM openjdk:22-jdk-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="26.2" \
    GEYSER_VERSION="2.7.0-SNAPSHOT-787" \
    FLOODGATE_VERSION="2.2.4-SNAPSHOT-28"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/26.2/0.19.3/1.1.2/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods
    
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/vmQp7ixA/fabric-api-0.157.0%2B26.2.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/wKkoqHrH/versions/zNwNFPWD/Geyser-Fabric-2.11.1-b1216.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/urOFTrVX/Floodgate-Fabric-2.2.6-b67.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/Fb4jn8m6/versions/sOoH5kkd/FallingTree-26.2-25.jar -O mods/fallingtree.jar && \
    wget https://cdn.modrinth.com/data/kieAM9Us/versions/Iy49DpF5/ly-graves-3.0.1.jar -O mods/graves.jar && \
    wget https://cdn.modrinth.com/data/5ibSyLAz/versions/XqW7xO2k/inventorysorter-fabric-3.0.0%2Bmc26.2.jar -O mods/sorting.jar && \
    wget https://cdn.modrinth.com/data/9s6osm5g/versions/Nv3xnWXd/cloth-config-26.2.155.jar -O mods/clothconfig.jar && \
    wget https://cdn.modrinth.com/data/e0M1UDsY/versions/M75JwjyS/collective-26.2.0-8.39.jar -O mods/collective.jar && \
    wget https://cdn.modrinth.com/data/xGdtZczs/versions/w0N4I45x/polymer-bundled-0.17.3%2B26.2.jar -O mods/polymer.jar && \
    wget https://cdn.modrinth.com/data/8oi3bsk5/versions/OxfI2n80/Terralith_26.2_v2.6.4.jar -O mods/terralith.jar && \
    wget https://cdn.modrinth.com/data/muf0XoRe/versions/dz8fp9GC/repurposed_structures-7.7.5%2B26.2-fabric.jar -O mods/repurposedstrucs.jar && \
    https://cdn.modrinth.com/data/codAaoxh/versions/3uBvRFE9/midnightlib-fabric-1.9.3%2B26.2.jar -O mods/midnight.jar
    
    
    
    
    

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
