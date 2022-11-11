docker run -d\
  --name=sonarr \
  -e PUID=1002 \
  -e PGID=1002 \
  -e TZ=america/new_york \
  -p 8989:8989 \
  -v /mnt/hdd/ps2/KrishNaik/mediserv/tv:/tv \
  -v /mnt/hdd/ps2/KrishNaik/mediserv/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/sonarr
  
  docker run -d \
 --name=radarr \
  -e PUID=1002 \
  -e PGID=1002 \
  -e TZ=america/new_york \
  -p 7878:7878 \
  -v /mnt/hdd/ps2/KrishNaik/mediserv/movies:/movies \
  -v /mnt/hdd/ps2/KrishNaik/mediserv/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/radarr

  docker run -d \
--name=portainer \
-p 8000:8000 \
-p 9000:9000 \
--restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v portainer_data:/data \
portainer/portainer-ce


docker run --cap-add=NET_ADMIN -d \
  --name=transmission\
  -e PUID=1002 \
  -e PGID=1002 \
  -v /mnt/hdd/ps2/KrishNaik/mediserv/transmission/data:/data \
  -v /mnt/hdd/ps2/KrishNaik/mediserv/transmission/downloads:/downloads \
  -v /mnt/hdd/ps2/KrishNaik/mediserv/transmission/incomplete:/incomplete-downloads \
  -e NORDVPN_PROTOCOL=tcp \
  -e OPENVPN_PROVIDER=FASTESTVPN \
  -e OPENVPN_CONFIG=US-Seattle-TCP\
  -e OPENVPN_USERNAME=rushic24@gmail.com\
  -e OPENVPN_PASSWORD=SpDhndj4B84EEW \
  -e LOCAL_NETWORK=192.168.1.0/24\
  -e TRANSMISSION_DOWNLOAD_DIR=/downloads\
  -e TRANSMISSION_INCOMPLETE_DIR=/incomplete-downloads\
  --log-driver json-file\
  --log-opt max-size=10m \
  -p 9091:9091 \
--restart=always \
  haugene/transmission-openvpn


   docker run --cap-add=NET_ADMIN -d \
             --sysctl=net.ipv6.conf.all.disable_ipv6=1 \
              -v /mnt/hdd/ps2/KrishNaik/mediserv/transmission/downloads/:/download \
              -v /home/pi/Downloads/TCP_Files/:/config \
              -e OPENVPN_PROVIDER=FASTESTVPN \
              -e OPENVPN_CONFIG=US-Seattle-TCP \
              -e OPENVPN_USERNAME=rushic24@gmail.com\
              -e OPENVPN_PASSWORD=SpDhndj4B84EEW \
              -e LOCAL_NETWORK=192.168.1.0/24 \
              -p 8112:8112 \
              ebrianne/docker-deluge-openvpn