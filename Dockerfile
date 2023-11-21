# Use the official OpenJDK image as the base image
FROM arm64v8/openjdk:17-bullseye

# Set environment variables
ENV MINECRAFT_VERSION="1.20.2" \
    GEYSER_VERSION="2.0.0-SNAPSHOT" \
    FLOODGATE_VERSION="2.0"

# Create and set the working directory
RUN mkdir -p /minecraft
WORKDIR /minecraft

# Download the Minecraft server and accept the EULA
RUN wget https://meta.fabricmc.net/v2/versions/loader/1.20.2/0.14.24/0.11.2/server/jar -O minecraft_server.jar && \
    echo "eula=true" > eula.txt

#download Mods
RUN mkdir mods && \
    wget https://cdn.modrinth.com/data/P7dR8mSH/versions/FhOnpSMY/fabric-api-0.90.7%2B1.20.2.jar -O mods/fabric_api.jar && \
    wget https://cdn.modrinth.com/data/9s6osm5g/versions/jvy82BGQ/cloth-config-12.0.111-fabric.jar -O cloth.jar && \
    wget https://cdn.modrinth.com/data/TWsbC6jW/versions/4aO595R4/AdditionalStructures-1.20.x-%28v.4.2.1%29.jar -O mods/add_strucs.jar && \
    wget https://cdn.modrinth.com/data/egyqODDj/versions/t2PB8GHU/spellbound-weapons-v4.0.5g.jar -O mods/bound_wepons.jar && \
    wget https://cdn.modrinth.com/data/HJR6V0I2/versions/4ZQjIDUu/more_mobs-v1.5-mc1.14x-1.20x-mod.jar -O mo_mobs.jar && \ 
    wget https://cdn.modrinth.com/data/Fb4jn8m6/versions/7PRbBpzE/FallingTree-1.20.2-5.0.3.jar -O falling_tree.jar && \
    wget https://cdn.modrinth.com/data/uXXizFIs/versions/unerR5MN/ferritecore-6.0.1-fabric.jar -O ferrite.jar && \
    wget https://cdn.modrinth.com/data/gvQqBUqZ/versions/qdzL5Hkg/lithium-fabric-mc1.20.2-0.12.0.jar -O lithium.jar && \
    wget https://cdn.modrinth.com/data/yn9u3ypm/versions/v0FIdWkz/graves-3.1.1%2B1.20.2.jar -O graves.jar && \
    wget https://cdn.modrinth.com/data/fQEb0iXm/versions/cQ60Ouax/krypton-0.2.4.jar -O krypton.jar
    
# Download GeyserMC and Floodgate
RUN wget https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/fabric/build/libs/Geyser-Fabric.jar -O mods/Geyser.jar && \
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
