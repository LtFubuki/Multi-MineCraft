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
    wget https://mediafilez.forgecdn.net/files/5499/595/modernfix-fabric-5.18.5%2Bmc1.21.jar -O mods/modernfix.jar && \
    wget https://mediafilez.forgecdn.net/files/5485/657/sodium-fabric-0.5.11%2Bmc1.21.jar -O mods/sodium.jar && \
    wget https://mediafilez.forgecdn.net/files/5448/487/lithium-fabric-mc1.21-0.12.7.jar -O mods/lithium.jar && \
    wget https://mediafilez.forgecdn.net/files/5434/182/ferritecore-7.0.0-fabric.jar -O mods/ferritecore.jar && \
    wget https://mediafilez.forgecdn.net/files/5425/57/ImmediatelyFast-Fabric-1.2.18%2B1.21.jar -O mods/imediatefast.jar && \
    wget https://mediafilez.forgecdn.net/files/5426/96/letmedespawn-1.3.0.jar -O mods/letmedespawn.jar && \
    wget https://mediafilez.forgecdn.net/files/5448/651/particle_core-0.2.3%2B1.21.jar -O mods/particlecore.jar && \
    wget https://mediafilez.forgecdn.net/files/5487/238/loadmychunks-1.0.5-hf2%2B1.21%2Bfabric.jar -O mods/loadmychunks.jar && \
    wget https://mediafilez.forgecdn.net/files/5430/24/Clumps-fabric-1.21-18.0.0.1.jar -O mods/clumps.jar && \
    wget https://mediafilez.forgecdn.net/files/5434/152/spark-1.10.73-fabric.jar -O mods/spark.jar && \
    wget https://mediafilez.forgecdn.net/files/5496/418/Neruina-2.1.0-fabric%2B1.21.jar -O mods/neruna.jar && \
    wget https://mediafilez.forgecdn.net/files/5432/203/servercore-fabric-1.5.3%2B1.21.jar -O mods/servercore.jar && \
    wget https://mediafilez.forgecdn.net/files/5435/263/graves-3.4.1%2B1.21.jar -O mods/graves.jar && \
    wget https://mediafilez.forgecdn.net/files/5500/755/waystones-fabric-1.21-21.0.7.jar -O mods/waystones.jar && \
    wget https://mediafilez.forgecdn.net/files/5489/688/BiomesOPlenty-fabric-1.21-21.0.0.11.jar -O mods/biomesoplenty.jar && \
    wget https://mediafilez.forgecdn.net/files/5465/222/mcw-bridges-3.0.0-mc1.21fabric.jar -O mods/macawbridges.jar && \
    wget https://mediafilez.forgecdn.net/files/5493/289/Jade-1.21-Fabric-15.1.3.jar -O mods/jade.jar && \
    wget https://mediafilez.forgecdn.net/files/5429/912/SereneSeasons-fabric-1.21-10.0.0.2.jar -O mods/seasons.jar && \
    wget https://mediafilez.forgecdn.net/files/5489/65/fallingtrees-fabric-0.12.3-1.21.jar -O mods/fallingtree.jar && \
    wget https://mediafilez.forgecdn.net/files/5439/797/htm-1.1.13.jar -O mods/htm.jar && \
    wget https://cdn.modrinth.com/data/j5niDupl/versions/K3NFTG3d/goml-1.13.0%2B1.21-rc1.jar -O mods/getoffmylawn.jar && \
    wget https://mediafilez.forgecdn.net/files/5485/36/balm-fabric-1.21-21.0.11.jar -O mods/balm.jar && \
    wget https://mediafilez.forgecdn.net/files/5483/774/GlitchCore-fabric-1.21-2.0.0.2.jar -O mods/glitchcore.jar && \
    wget https://mediafilez.forgecdn.net/files/5490/619/architectury-13.0.3-fabric.jar -O mods/architechuary.jar && \
    wget https://mediafilez.forgecdn.net/files/5485/123/pandalib-fabric-0.3-1.21.jar -O mods/pandalib.jar && \
    wget https://mediafilez.forgecdn.net/files/5481/991/resourcefulconfig-fabric-1.21-3.0.2.jar -O mods/resourcefulconfig.jar && \
    wget https://mediafilez.forgecdn.net/files/5429/866/TerraBlender-fabric-1.21-4.0.0.1.jar -O mods/terrablender.jar && \
    wget https://mediafilez.forgecdn.net/files/5460/139/geckolib-fabric-1.21-4.5.6.jar -O mods/geckolib.jar
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/wKkoqHrH/versions/roQJJk43/geyser-fabric-2.4.0-SNAPSHOT%2Bbuild.588.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/D4KXqjtC/Floodgate-Fabric-2.2.3-SNAPSHOT%2Bbuild.28.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/P1OZGk5p/versions/fojFzCyd/ViaVersion-5.0.2-SNAPSHOT.jar -O mods/viaversion.jar && \
    wget https://cdn.modrinth.com/data/NpvuJQoq/versions/HP0St2QS/ViaBackwards-5.0.2-SNAPSHOT.jar -O mods/viabackwards.jar && \
    wget https://mediafilez.forgecdn.net/files/5479/621/ViaFabric-0.4.14%2B74-main.jar -O mods/viafabric.jar

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
