#!/bin/sh

# Start GeyserMC and Floodgate
java -jar mods/Geyser.jar & java -jar mods/Floodgate.jar &

# Start the Minecraft server
exec java -Xmx2G -jar minecraft_server.jar --nogui
