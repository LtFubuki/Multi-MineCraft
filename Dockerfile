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
    wget https://cdn.modrinth.com/data/gWO6Zqey/versions/cGJlnDAP/vanilla-refresh-1.4.20b.jar -O mods/vanillarefresh.jar && \
    wget https://cdn.modrinth.com/data/tpehi7ww/versions/k5UAHKdy/dungeons-and-taverns-v4.1.jar -O mods/dung.jar && \
    wget https://cdn.modrinth.com/data/xGdtZczs/versions/Bbj5Ts5L/polymer-bundled-0.9.4%2B1.21.jar -O mods/polymer.jar && \
    wget https://cdn.modrinth.com/data/iWkVbeKr/versions/AhWjCf1A/glideaway-1.2.1%2B1.21.jar -O mods/glider.jar && \
    wget https://cdn.modrinth.com/data/MikpSrAF/versions/6Ta3P3ds/polyfactory-0.4.0-pre.5%2B1.21.jar -O mods/polyfactory.jar && \
    wget https://cdn.modrinth.com/data/m5NB7FJE/versions/aeb2airJ/polydex-1.2.2%2B1.21.jar -O mods/polydex.jar && \
    wget https://cdn.modrinth.com/data/gqRXDo8B/versions/3Wfwymh0/villagernames-1.21.0-8.0.jar -O mods/villagernames.jar && \
    wget https://cdn.modrinth.com/data/tOoh2eQm/versions/Z92SIDcE/petnames-1.21.0-3.3.jar -O mods/petnames.jar
    
# Download GeyserMC and Floodgate / core mods
RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/oIVA3FbL/fabric-api-0.100.4%2B1.21.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/e0M1UDsY/versions/ZaTRzQs8/collective-1.21.0-7.70.jar -O mods/collective.jar && \
    wget https://mediafilez.forgecdn.net/files/5435/263/graves-3.4.1%2B1.21.jar -O mods/graves.jar && \
    wget https://mediafilez.forgecdn.net/files/5439/797/htm-1.1.13.jar -O mods/htm.jar && \
    wget https://cdn.modrinth.com/data/j5niDupl/versions/K3NFTG3d/goml-1.13.0%2B1.21-rc1.jar -O mods/getoffmylawn.jar && \
    wget https://mediafilez.forgecdn.net/files/5499/595/modernfix-fabric-5.18.5%2Bmc1.21.jar -O mods/modernfix.jar && \
    wget https://mediafilez.forgecdn.net/files/5485/657/sodium-fabric-0.5.11%2Bmc1.21.jar -O mods/sodium.jar && \
    wget https://mediafilez.forgecdn.net/files/5448/487/lithium-fabric-mc1.21-0.12.7.jar -O mods/lithium.jar && \
    wget https://mediafilez.forgecdn.net/files/5434/182/ferritecore-7.0.0-fabric.jar -O mods/ferritecore.jar && \
    wget https://cdn.modrinth.com/data/wKkoqHrH/versions/roQJJk43/geyser-fabric-2.4.0-SNAPSHOT%2Bbuild.588.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/D4KXqjtC/Floodgate-Fabric-2.2.3-SNAPSHOT%2Bbuild.28.jar -O mods/Floodgate.jar && \
    wget https://cdn.modrinth.com/data/P1OZGk5p/versions/fojFzCyd/ViaVersion-5.0.2-SNAPSHOT.jar -O mods/viaversion.jar && \
    wget https://cdn.modrinth.com/data/NpvuJQoq/versions/HP0St2QS/ViaBackwards-5.0.2-SNAPSHOT.jar -O mods/viabackwards.jar && \
    wget https://mediafilez.forgecdn.net/files/5485/36/balm-fabric-1.21-21.0.11.jar -O mods/balm.jar && \
    wget https://mediafilez.forgecdn.net/files/5483/774/GlitchCore-fabric-1.21-2.0.0.2.jar -O mods/glitchcore.jar && \
    wget https://mediafilez.forgecdn.net/files/5490/619/architectury-13.0.3-fabric.jar -O mods/architechuary.jar && \
    wget https://mediafilez.forgecdn.net/files/5485/123/pandalib-fabric-0.3-1.21.jar -O mods/pandalib.jar && \
    wget https://mediafilez.forgecdn.net/files/5429/866/TerraBlender-fabric-1.21-4.0.0.1.jar -O mods/terrablender.jar && \
    wget https://mediafilez.forgecdn.net/files/5425/57/ImmediatelyFast-Fabric-1.2.18%2B1.21.jar -O mods/imediatefast.jar && \
    wget https://mediafilez.forgecdn.net/files/5426/96/letmedespawn-1.3.0.jar -O mods/letmedespawn.jar && \
    wget https://cdn.modrinth.com/data/abooMhox/versions/astoQXO2/treeharvester-1.21.0-8.9.jar -O mods/fallingtree.jar && \
    wget https://cdn.modrinth.com/data/8oi3bsk5/versions/5k90Bexh/Terralith_1.21_v2.5.3.jar -O mods/terralith.jar && \
    wget https://mediafilez.forgecdn.net/files/5493/289/Jade-1.21-Fabric-15.1.3.jar -O mods/jade.jar && \
    wget https://mediafilez.forgecdn.net/files/5448/651/particle_core-0.2.3%2B1.21.jar -O mods/particlecore.jar && \
    wget https://mediafilez.forgecdn.net/files/5340/851/serverpingerfixer-1.0.5.jar -O mods/serverpinger.jar && \
    wget https://mediafilez.forgecdn.net/files/5434/152/spark-1.10.73-fabric.jar -O mods/spark.jar && \
    wget https://mediafilez.forgecdn.net/files/5460/550/krypton-0.2.8.jar -O mods/krypton.jar && \
    wget https://mediafilez.forgecdn.net/files/5496/418/Neruina-2.1.0-fabric%2B1.21.jar -O mods/neruna.jar && \
    wget https://mediafilez.forgecdn.net/files/5424/659/packetfixer-fabric-1.4.1-1.21-to-1.21.jar -O mods/packetfixer.jar && \
    wget https://mediafilez.forgecdn.net/files/5432/203/servercore-fabric-1.5.3%2B1.21.jar -O mods/servercore.jar && \
    wget https://mediafilez.forgecdn.net/files/5430/24/Clumps-fabric-1.21-18.0.0.1.jar -O mods/clumps.jar && \
    wget https://cdn.modrinth.com/data/TWsbC6jW/versions/2lPBBaF4/AdditionalStructures-1.21-%28v.5.0.0-fabric%29.jar -O mods/addstrucs.jar && \
    wget https://mediafilez.forgecdn.net/files/5481/991/resourcefulconfig-fabric-1.21-3.0.2.jar -O mods/resourcefulconfig.jar && \
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
