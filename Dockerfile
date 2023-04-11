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
    wget https://cdn.modrinth.com/data/cnIatHrN/versions/8QjF9W94/universal_shops-1.2.0%2B1.19.4.jar -O mods/universal_shops.jar && \
    wget https://cdn.modrinth.com/data/nmJ9dZtI/versions/hlAXAEA6/expanded-axe-enchanting-1.0.5.jar -O mods/expanded_axe.jar && \
    wget https://cdn.modrinth.com/data/mbBFD52c/versions/Gukcfrz6/expanded-armor-enchanting-1.0.4.jar -O mods/expanded_armor.jar && \
    wget https://cdn.modrinth.com/data/aa4EyFDP/versions/vCB24GVg/expanded-weapon-enchanting-1.0.4.jar -O mods/expanded_weapons.jar && \
    wget https://cdn.modrinth.com/data/nHOlhRg9/versions/2ruNLl0H/expanded-trident-enchanting-1.0.5.jar -O mods/expanded_tridents.jar && \
    wget https://cdn.modrinth.com/data/fdtm99de/versions/g1B0fOgq/betternethermap-1.2-1.19.3.jar -O mods/better_nether_map.jar && \
    wget https://cdn.modrinth.com/data/jTUiUpsh/versions/zhpbC0v6/ShowMeWhatYouGot-1.19.4-1.1.0.jar -O mods/SMWYG.jar && \
    wget https://cdn.modrinth.com/data/8RtckdKf/versions/dyTsFisd/rpgstats-5.0.9%2B1.19.2.jar -O mods/rpg_stats.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/vHvEE5VR/graves-2.2.1%2B1.19.4.jar -O mods/graves.jar && \
    wget https://cdn.modrinth.com/data/PTGd6dWp/versions/ZlwA2G0d/mostructures-1.4.3%2B1.19.4.jar -O mods/mo_structures.jar && \
    wget https://cdn.modrinth.com/data/fgmhI8kH/versions/3eXWBWdB/ctov-3.1.8.jar -O mods/CTOV.jar && \
    wget https://cdn.modrinth.com/data/CVBAErky/versions/e7rJNBPs/%5BUniversal%5DImmersive%20Structures-2.0.7.jar -O mods/universal_structures.jar

# Download GeyserMC and Floodgate
RUN wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/fabric -O Geyser.jar && \
    wget https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/fabric -O Floodgate.jar

# Copy configuration files and start script
COPY server.properties ./
COPY geyser-config.yml ./
COPY floodgate-config.yml ./
COPY start.sh ./

# Make the start script executable
RUN chmod +x start.sh

# Expose server ports
EXPOSE 25565 19132/udp

# Start the server using the start.sh script
CMD ["./start.sh"]
