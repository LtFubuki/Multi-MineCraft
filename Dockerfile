# Use the official OpenJDK image as the base image
FROM openjdk:17-alpine

# Set environment variables
ENV MINECRAFT_VERSION="1.19.4" \
    GEYSER_VERSION="2.0.0-SNAPSHOT" \
    FLOODGATE_VERSION="2.0"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.19.4/0.14.19/0.11.2/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods && \
    wget https://mediafilez.forgecdn.net/files/4474/468/fabric-api-0.77.0%2B1.19.4.jar -O mods/fabric_api.jar && \
    wget https://mediafilez.forgecdn.net/files/4466/959/fabric-language-kotlin-1.9.3%2Bkotlin.1.8.20.jar -O mods/fabric_kotlin.jar && \
    wget https://cdn-raw.modrinth.com/data/9s6osm5g/versions/6XGTNEII/cloth-config-10.0.96-fabric.jar -O mods/cloth_config.jar && \
    wget https://cdn-raw.modrinth.com/data/e0M1UDsY/versions/PvuijvUl/collective-1.19.4-6.54.jar -O mods/collective.jar && \
    wget https://cdn-raw.modrinth.com/data/RAXqYPH1/versions/ECS37OvX/Annotated-DI-Fabric-4.0.2%2B1.19.2.jar -O mods/annotated.jar && \
    wget https://cdn-raw.modrinth.com/data/ING0LAPF/versions/taLKbHvA/Fireplace-Lib-Fabric-7.0.3%2B1.19.2.jar -O mods/fireplace_lib.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/vHvEE5VR/graves-2.2.1%2B1.19.4.jar -O mods/graves.jar && \
    wget https://cdn-raw.modrinth.com/data/fRQREgAc/versions/jHY0XK3D/Dynmap-3.5-beta-3-fabric-1.19.4.jar -O mods/dyn_map.jar && \
    wget https://cdn.modrinth.com/data/PTGd6dWp/versions/ZlwA2G0d/mostructures-1.4.3%2B1.19.4.jar -O mods/mo_structures.jar && \
    wget https://cdn-raw.modrinth.com/data/gvQqBUqZ/versions/14hWYkog/lithium-fabric-mc1.19.4-0.11.1.jar -O mods/lithium.jar && \
    wget https://cdn-raw.modrinth.com/data/hEOCdOgW/versions/mc1.19.x-0.8.1/phosphor-fabric-mc1.19.x-0.8.1.jar -O mods/phosphor.jar && \
    wget https://cdn-raw.modrinth.com/data/AANobbMI/versions/b4hTi3mo/sodium-fabric-mc1.19.4-0.4.10%2Bbuild.24.jar -O mods/sodium.jar && \
    wget https://cdn-raw.modrinth.com/data/Fb4jn8m6/versions/BQ6i1U5X/FallingTree-1.19.4-3.12.1.jar -O mods/falling_tree.jar && \
    wget https://cdn-raw.modrinth.com/data/fgmhI8kH/versions/3eXWBWdB/ctov-3.1.8.jar -O mods/CTOV.jar && \
    wget https://cdn-raw.modrinth.com/data/TWsbC6jW/versions/wtEjVsXc/AdditionalStructures-1.19.x-%28v.4.1.1%29.jar -O mods/add_structures.jar && \
    wget https://cdn-raw.modrinth.com/data/Ua7DFN59/versions/h32n7OPC/YungsApi-1.19.4-Fabric-3.10.1.jar -O mods/yungs_api.jar && \
    wget https://cdn-raw.modrinth.com/data/XNlO7sBv/versions/XPZvt9X7/YungsBetterDesertTemples-1.19.4-Fabric-2.4.0.jar -O mods/better_temples.jar && \
    wget https://cdn-raw.modrinth.com/data/3dT9sgt4/versions/JY9IpWlt/YungsBetterOceanMonuments-1.19.4-Fabric-2.3.0.jar -O mods/better_oceans.jar && \
    wget https://cdn-raw.modrinth.com/data/t5FRdP87/versions/EVkItnSb/YungsBetterWitchHuts-1.19.4-Fabric-2.3.0.jar -O mods/better_huts.jar && \
    wget https://cdn-raw.modrinth.com/data/Ht4BfYp6/versions/pWD9qGts/YungsBridges-1.19.4-Fabric-3.3.0.jar -O mods/better_bridges.jar && \
    wget https://cdn-raw.modrinth.com/data/ZYgyPyfq/versions/MUzrN78m/YungsExtras-1.19.4-Fabric-3.3.0.jar -O mods/yung_extras.jar && \
    wget https://cdn-raw.modrinth.com/data/Z2mXHnxP/versions/tS9cnHTd/YungsBetterNetherFortresses-1.19.4-Fabric-1.2.0.jar -O mods/better_nether.jar && \
    wget https://cdn-raw.modrinth.com/data/8RtckdKf/versions/6N8NcYZO/rpgstats-4.5.0%2B1.19.2.jar -O mods/rpg_stats.jar && \
    wget https://cdn-raw.modrinth.com/data/kOuPUitF/versions/nkFdI1sJ/healingcampfire-1.19.4-5.1.jar -O mods/healing_campfire.jar && \
    wget https://cdn-raw.modrinth.com/data/cwKtPx6L/versions/1.1.2-1.19/SimplyHouses-1.1.2-1.19-fabric.jar -O mods/simply_houses.jar && \
    wget https://cdn-raw.modrinth.com/data/o1C1Dkj5/versions/ndfXFrkZ/YungsBetterDungeons-1.19.4-Fabric-3.4.0.jar -O mods/better_dung.jar && \
    wget https://cdn-raw.modrinth.com/data/HjmxVlSr/versions/TzrcWYpl/YungsBetterMineshafts-1.19.4-Fabric-3.4.0.jar -O mods/better_mineshaft.jar && \
    wget https://cdn-raw.modrinth.com/data/kidLKymU/versions/AWml7PPK/YungsBetterStrongholds-1.19.4-Fabric-3.4.0.jar -O mods/better_stronghold.jar && \
    wget https://cdn-raw.modrinth.com/data/doqSKB0e/versions/krxsLfUl/styled-chat-2.1.5%2B1.19.4.jar -O mods/styled_chat.jar && \
    wget https://cdn-raw.modrinth.com/data/DQIfKUHf/versions/cEi0Qx95/styledplayerlist-2.3.0%2B1.19.3.jar -O mods/styled_list.jar && \
    wget https://cdn-raw.modrinth.com/data/NNqujQWr/versions/1.0.11/healthcare-1.0.11.jar -O mods/helthcare.jar && \
    wget https://cdn-raw.modrinth.com/data/5ibSyLAz/versions/c28ouOKs/InventorySorter-1.8.10-1.19.4.jar -O mods/inv_sorter.jar

# Download GeyserMC and Floodgate
RUN wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/fabric -O mods/Geyser.jar && \
    wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate-Fabric/job/master/lastSuccessfulBuild/artifact/build/libs/floodgate-fabric.jar -O mods/Floodgate.jar

# Copy configuration files and start script
COPY server.properties ./
COPY geyser-config.yml ./
COPY floodgate-config.yml ./
COPY start.sh ./

# Make the start script executable
RUN chmod +x start.sh

# Expose server ports
EXPOSE 25565 8123 19132/udp

# Start the server using the start.sh script
CMD ["./start.sh"]
