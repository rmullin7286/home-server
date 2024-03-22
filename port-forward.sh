#!/usr/bin/env sh

# This script forwards all relevant ports on my server using ssh tunneling. 
# This is how I access certain admin tools like Radarr and Sonnarr without
# having to expose them to the public internet.

# Right now I'm grabbing the public ip manually from the remote access page on
# Plex, but I'm trying to find a better way to do that automatically.

IP="73.239.240.122"

QBITTORRENT=8080
RADARR=7878
SONARR=8989
PROWLARR=9696

ssh -L $QBITTORRENT:localhost:$QBITTORRENT \
  -L $RADARR:localhost:$RADARR \
  -L $SONARR:localhost:$SONARR \
  -L $PROWLARR:localhost:$PROWLARR \
  ryan@$IP
