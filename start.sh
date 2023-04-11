#!/bin/sh

# Start GeyserMC and Floodgate
java -jar Geyser.jar & java -jar Floodgate.jar &

# Start the Minecraft server
exec java -Xmx2G -jar minecraft_server.jar --nogui
