# MEDIA SERVER

## Architecture

![media-server](../assets/media-server/media-server.png)

## Docs

Mediastack:  

- https://github.com/geekau/mediastack
- https://MediaStack.Guide

Config:  
  
- https://trash-guides.info

Indexer/Downloader:  

- https://fmhy.net/downloadpiracyguide
- torrent:
  - https://fmhy.net/videopiracyguide#torrent-sites
- usenet:
  - https://fmhy.net/downloadpiracyguide#usenet
  - https://docs.google.com/document/d/1TwUrRj982WlWUhrxvMadq6gdH0mPW0CGtHsTOFWprCo/mobilebasic

## Setup

- change config to access ?qbtorrent? interface
- prowlarr: setup sonarr / radarr
- prowlarr: setup indexer
- sonarr: setup client: qbtorrent
- radarr: setup client: qbtorrent
- use correct URLs

## TODO

- setup wireguard / use openvpn conf
- SWAG + DNS
- Nom de domaine khaaz.me externe pour pointer sur SWAG
- Authelia
- configs:
  - automatisation des dernières config
  - configuration
    - communication de base
    - languages (fr / en + vo avec sous titre pour anime)
  - seeding des configs / query SQL etc pour que tout soit "en dur"
  - faire marcher bazarr
- workflow final:
  - overseer into =>
  - DL 4k / 1080p (check pour le double DL = sync dans la bibliothèque)
  - DL anime (+ bonne langue)
  - DL en FR / en selon le profile (multi langue si possible) 
- VM with proxmox + test
- ansible pour automatiser proxmox
- Faire un petit guide / sortir les options a remplir ou pas en fonction de ce que on veut activer vs les trucs fonctionnels par defaut

TODO conf:

- DATA CONFIG:
  - overseer
  - bazarr
- DATA SQL:
  - sonarr
  - radarr
  - radarr4k
  - prowlarr
- AUTOMATISATION:
  - qbit
  - maintainerr
  - plex
- OK:
  - /
