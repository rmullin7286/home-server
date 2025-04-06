# home-server

Configuration and scripts for my home server.

# How to use

Most of the tools in my home server are spun up using the docker-compose file provided in the repo. You'll need to have
docker and the docker-compose extension. Instructions to install can be found [here](https://docs.docker.com/compose/install/)

# Overview of components

I run the following services on my server:

| service         | port  | description                                                                                                                                                                                                                                                  |
| --------------- | ----- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| qbittorrent-vpn | 8080  | A web based version of qbittorent with built in OpenVPN integration. If you're torrenting, you'll want to use a VPN of some kind so you don't get hounded by your ISP with copyright notices                                                                 |
| nzbget          | 6788  | A download agent for usenet files. Not strictly necessary but I find usenet a lot more reliable than torrenting for finding more obscure or older media. You'll need a subscription to both a usenet provider and an indexer (I use newshosting and nzbgeek) |
| sonarr          | 8989  | A really useful tool with a web ui to automatically source from multiple torrent/usenet indexers to download shows. Can be set to automatically download new releases as they come out.                                                                      |
| radarr          | 7878  | Same as sonarr, but for movies                                                                                                                                                                                                                               |
| prowlarr        | 9696  | Used by sonarr and radarr to manage different torrent/usenet trackers                                                                                                                                                                                        |
| lidarr          | 8686  | Same as sonarr but for music. I find the results from torrenting lack luster, so I'm currently migrating to soulseek for peer to peer sharing                                                                                                                |
| slskd           | 50300 | A peer to peer sharing service for music. You'll find way more results on here especially if you're into more obscure stuff                                                                                                                                  |

# Setting up environment variables

I keep a few of the config values in separate environment variables so that I can keep this config public without leaking passwords. `docker-compose` will automatically pick up variables defined a `.env` file in the same directory, so you can keep them all there.

You'll need to define the following, depending on which services you use:

| name                      | description                                                                                         |
| ------------------------- | --------------------------------------------------------------------------------------------------- |
| VPN_USERNAME/VPN_PASSWORD | Your OpenVPN login credentials for connecting qbittorrent to your provider                          |
| NZBGET_USER/NZBGET_PASS   | Same for usenet                                                                                     |
| CONFIG_DIRECTORY          | The directory where all application specific configurationn will be stored (mine is `$HOME/config`) |
| DATA_DIRECTORY            | The directory where all data will be stored (torrent downloads, media library, etc.)                |

# Configuring the "arr" tools

Sonarr/Radar/Prowlarr/Lidarr requires some extra configuration to get up and running. I kinda forgot how I did this all because it's been so long since I've had to tweak it, but the [trash guides](https://trash-guides.info/Sonarr/) are pretty helpful. They require a bit of
initial tweaking and troubleshooting but have been running rock solid ever since.

# Usenet

Usenet isn't necessary and you can get by with just public torrent trackers, but I've found it worth the cost, especially since you can get mega discounts by going through the [usenet reddit wiki](https://www.reddit.com/r/usenet/wiki/providerdeals/), like 90%+ off. You still have to pay for the provider, and the indexers usually require a one time entrance fee (see: [nzbgeek](https://www.nzbgeek.info/)), but I find it worth it.

# Future work

## Migrating Plex

I'm currently running a plex server to serve all of the media I get with the above tools, and that's running outside of docker as a systemd service on the base Arch server. Once I figure out how to transfer all of the configuration files I have into the docker version I'll get it setup in here.

Plex has a one time cost to get access to all the features. If I were to go back and do it again, I may have used [jellyfin](https://jellyfin.org/) instead which is a FOSS alternative, but I hear their client support is lacking in comparison, at least last I checked.

## Exposing ports through nginx

I currently expose all of the ports for the different services raw to my local network. Probably bad practice, it might be a good idea to get a reverse proxy through nginx going in front of all of them. I think there are docker containers for that too.

## VPN for remote access

To access my services remotely I expose my SSH port to public internet and use ssh port forwarding to forward traffic from a remote machine. There's a script for it in the repo, but it's a little cumbersome and it would be cool to get tailscale or something setup to make the process smoother.
