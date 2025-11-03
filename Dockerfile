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
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.21.10/0.17.3/1.1.0/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods
    
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/rhkWp6Ar/fabric-api-0.137.0%2B1.21.10.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/wKkoqHrH/versions/SM2rfos8/geyser-fabric-Geyser-Fabric-2.9.0-b979.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/QFAMeMNB/Floodgate-Fabric-2.2.6-b51.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/uXXizFIs/versions/MGoveONm/ferritecore-8.0.2-fabric.jar -O mods/ferrite.jar && \
    wget https://cdn.modrinth.com/data/gvQqBUqZ/versions/oGKQMdyZ/lithium-fabric-0.20.0%2Bmc1.21.10.jar -O mods/lithium.jar && \
    wget https://cdn.modrinth.com/data/nvQzSEkH/versions/qC0qUqL5/Jade-1.21.9-Fabric-20.0.5.jar -O mods/jade.jar && \
    wget https://cdn.modrinth.com/data/VSNURh3q/versions/G5CLVk95/c2me-fabric-mc1.21.10-0.3.5.1%2Brc.1.0.jar -O mods/conc.jar && \
    wget https://cdn.modrinth.com/data/gF3BGWvG/versions/MZ9uI929/open-parties-and-claims-fabric-1.21.10-0.25.8.jar -O mods/claims.jar && \
    wget https://cdn.modrinth.com/data/DjLobEOy/versions/NXAdx4ui/t_and_t-fabric-neoforge-1.13.7.jar -O mods/towns.jar && \
    wget https://cdn.modrinth.com/data/Fb4jn8m6/versions/hDjB8uAg/FallingTree-1.21.10-1.21.10.1.jar -O mods/fallingtree.jar && \
    wget https://cdn.modrinth.com/data/gqRXDo8B/versions/PlzaDKOA/villagernames-1.21.10-8.3.jar -O mods/villigarnames.jar && \
    wget https://cdn.modrinth.com/data/fgmhI8kH/versions/ZElsnCT3/%5Bfabric%5Dctov-3.5.10a.jar -O mods/villages.jar && \
    wget https://cdn.modrinth.com/data/4WWQxlQP/versions/TTQGy6U8/servercore-fabric-1.5.14%2B1.21.9.jar -O mods/servercode.jar && \
    wget https://cdn.modrinth.com/data/muf0XoRe/versions/Qn9MHk0P/repurposed_structures-7.5.22%2B1.21.9-fabric.jar -O mods/strucs.jar && \
    wget https://cdn.modrinth.com/data/OQAgZMH1/versions/YWXTj40n/MoogsVoyagerStructures-1.21-5.0.1.jar -O mods/moogs.jar && \
    wget https://cdn.modrinth.com/data/TWsbC6jW/versions/RURunGvI/AdditionalStructures-1.21.x-%28v.5.1.3-fabric%29.jar -O mods/addstrucs.jar && \
    wget https://cdn.modrinth.com/data/KX1XC0Oo/versions/oDpgbADk/formationsoverworld-1.0.5-mc1.21%2B.jar -O mods/formations.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/bJROTlRS/graves-3.9.0%2B1.21.9.jar -O mods/graves.jar && \
    wget https://cdn.modrinth.com/data/5ibSyLAz/versions/FX9V1bWK/inventorysorter-fabric-2.1.0%2Bmc1.21.9.jar -O mods/sorting.jar && \
    wget https://cdn.modrinth.com/data/ZsrrjDbP/versions/tTpWP44G/DungeonsAriseSevenSeas-1.21.x-1.0.4-fabric.jar -O mods/sevenseas.jar && \
    wget https://cdn.modrinth.com/data/tb5O1ssC/versions/AKVTh9cI/abridged-2.0.0-fabric-1.21.9.jar -O mods/bridged.jar &7 \
    wget https://cdn.modrinth.com/data/e0M1UDsY/versions/A0CFMmGr/collective-1.21.10-8.13.jar -O mods/collective.jar && \
    wget https://cdn.modrinth.com/data/cl223EMc/versions/ZvMKpvgf/cristellib-fabric-1.21.10-3.0.3.jar -O mods/crislib.jar && \
    wget https://cdn.modrinth.com/data/codAaoxh/versions/7RbEjTSq/midnightlib-1.8.3-fabric%2B1.21.9.jar -O mods/midnight.jar
    
    
    
    
    
    
    

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
