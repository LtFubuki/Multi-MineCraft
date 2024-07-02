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
    wget https://cdn.modrinth.com/data/9s6osm5g/versions/Yc8omJNb/cloth-config-15.0.127-fabric.jar -O mods/cloth.jar && \
    wget https://cdn.modrinth.com/data/gvQqBUqZ/versions/my7uONjU/lithium-fabric-mc1.21-0.12.7.jar -O mods/lithium.jar && \
    wget https://cdn.modrinth.com/data/uXXizFIs/versions/wmIZ4wP4/ferritecore-7.0.0-fabric.jar -O mods/ferritcore.jar && \
    wget https://cdn.modrinth.com/data/nmDcB62a/versions/AFvoBfkx/modernfix-fabric-5.18.3%2Bmc1.21.jar -O mods/modernfix.jar && \
    wget https://cdn.modrinth.com/data/QwxR6Gcd/versions/mOk69fib/Debugify-1.21%2B1.0.jar -O mods/debug.jar && \
    wget https://cdn.modrinth.com/data/1eAoo2KR/versions/Y8Wa10Re/YetAnotherConfigLib-3.5.0%2B1.21-fabric.jar -O mods/yetanotherconfig.jar && \
    wget https://cdn.modrinth.com/data/nPZr02ET/versions/nSxqDibl/netherportalfix-fabric-1.21-21.0.2.jar -O mods/netherfix.jar && \
    wget https://cdn.modrinth.com/data/MBAkmtvl/versions/ryOwjzmq/balm-fabric-1.21-21.0.11.jar -O mods/balm.jar && \
    wget https://cdn.modrinth.com/data/Fb4jn8m6/versions/7x1mqvWh/FallingTree-1.21-1.21.0.5.jar -O mods/fallingtree.jar && \
    wget https://cdn.modrinth.com/data/ftdbN0KK/versions/ac4a1Xj7/badpackets-fabric-0.8.1.jar -O mods/badpackets.jar && \
    wget https://cdn.modrinth.com/data/fALzjamp/versions/dPliWter/Chunky-1.4.16.jar -O mods/chunky.jar && \
    wget https://cdn.modrinth.com/data/XaDC71GB/versions/UlXj63sO/lithostitched-fabric-1.21-1.2.1.jar -O mods/lithed.jar && \
    wget https://cdn.modrinth.com/data/H7N61Wcl/versions/g5ED4w8B/dismountentity-1.21.0-3.3.jar -O mods/dismount.jar && \
    wget https://cdn.modrinth.com/data/gqRXDo8B/versions/3Wfwymh0/villagernames-1.21.0-8.0.jar -O mods/villagernames.jar && \
    wget https://cdn.modrinth.com/data/6AQIaxuO/versions/jOm0aorp/wthit-fabric-12.2.2.jar -O mods/wthit.jar && \
    wget https://cdn.modrinth.com/data/nfn13YXA/versions/l5RqB76W/RoughlyEnoughItems-16.0.729-fabric.jar -O mods/ritems.jar && \
    wget https://cdn.modrinth.com/data/lhGA9TYQ/versions/nW3HvWVP/architectury-13.0.3-fabric.jar -O mods/arch.jar && \
    wget https://cdn.modrinth.com/data/muf0XoRe/versions/SCBq1LMb/repurposed_structures-7.5.3%2B1.21-fabric.jar -O mods/repurposed.jar && \
    wget https://cdn.modrinth.com/data/codAaoxh/versions/HVILSMf5/midnightlib-fabric-1.5.7.jar -O mods/midnight.jar && \
    wget https://cdn.modrinth.com/data/LPjGiSO4/versions/BoQYkOMa/Nullscape_1.21_v1.2.6.jar -O mods/nullscape.jar && \
    wget https://cdn.modrinth.com/data/TWsbC6jW/versions/2lPBBaF4/AdditionalStructures-1.21-%28v.5.0.0-fabric%29.jar -O mods/addstrucs.jar && \
    wget https://cdn.modrinth.com/data/2ecVyZ49/versions/QFfBwOwT/Ksyxis-1.3.2.jar -O mods/krysix.jar && \
    wget https://cdn.modrinth.com/data/XVnUIUAQ/versions/2nLuXwjq/SnowUnderTrees-2.4.0%2B1.21.jar -O mods/snowunder.jar && \
    wget https://cdn.modrinth.com/data/SNVQ2c0g/versions/dMTEZn0q/mru-0.4.4%2B1.21.jar -O mods/mru.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/qtHZSwwl/graves-3.4.1%2B1.21.jar -O mods/graves.jar && \
    wget https://cdn.modrinth.com/data/FCTyEqkn/versions/7aXwwLYh/whereisit-2.5.0%2B1.21.jar -O mods/whereisit.jar && \
    wget https://cdn.modrinth.com/data/PTGd6dWp/versions/PJDAHUHg/mostructures-fabric-1.5.0%2B1.21.jar -O mods/mostrucs.jar && \
    wget https://cdn.modrinth.com/data/EJqeyaVz/versions/czJQJ7qH/nohostilesaroundcampfire-1.21.0-7.0.jar -O mods/nohostile.jar && \
    wget https://cdn.modrinth.com/data/tOoh2eQm/versions/Z92SIDcE/petnames-1.21.0-3.3.jar -O mods/petnames.jar && \
    wget https://cdn.modrinth.com/data/j5niDupl/versions/K3NFTG3d/goml-1.13.0%2B1.21-rc1.jar -O mods/getoffmylawn.jar && \
    wget https://cdn.modrinth.com/data/IEPAK5x6/versions/2tO12wyr/htm-1.1.13.jar -O mods/heythatsmine.jar && \
    wget https://cdn.modrinth.com/data/l0tpiNe7/versions/4kJXWBwz/rain-grow-1.2.jar -O mods/raingowth.jar && \
    wget https://cdn.modrinth.com/data/e0M1UDsY/versions/ZaTRzQs8/collective-1.21.0-7.70.jar -O mods/collective.jar && \
    wget https://cdn.modrinth.com/data/n6PXGAoM/versions/2n9CpLEp/betterstats-3.11.3%2Bfabric-1.21.jar -O mods/bss.jar && \
    wget https://cdn.modrinth.com/data/Eldc1g37/versions/EbhWGkSn/tcdcommons-3.11.1%2Bfabric-1.21.jar -O mods/tcdc.jar && \
    wget https://cdn.modrinth.com/data/gWO6Zqey/versions/cGJlnDAP/vanilla-refresh-1.4.20b.jar -O mods/vanillarefresh.jar
    
# Download GeyserMC and Floodgate
RUN wget https://cdn.modrinth.com/data/wKkoqHrH/versions/roQJJk43/geyser-fabric-2.4.0-SNAPSHOT%2Bbuild.588.jar -O mods/Geyser.jar && \
    wget https://cdn.modrinth.com/data/bWrNNfkb/versions/D4KXqjtC/Floodgate-Fabric-2.2.3-SNAPSHOT%2Bbuild.28.jar -O mods/Floodgate.jar

# Copy configuration files and start script
COPY server.properties ./
COPY geyser-config.yml ./
COPY floodgate-config.yml ./
COPY start.sh ./
COPY datapacks/ ./datapacks

# Make the start script executable
RUN chmod +x start.sh

# Expose server ports
EXPOSE 25565 8123 19132/udp

# Start the server using the start.sh script
CMD ["./start.sh"]
