```yml
version: "3.8"

networks:
  adwireguard:
    name: adwireguard
    ipam:
      config:
        - subnet: 10.8.2.0/24

services:
  wg-easy:
    image: weejewel/wg-easy
    container_name: wg-easy
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - WG_HOST=mydomain.tld
      - PASSWORD=secret
      - WG_PORT=51820 # Change VPN port if needed
      - WG_DEFAULT_ADDRESS=10.8.1.x
      - WG_DEFAULT_DNS=10.8.2.3 # The ADGUARD LOCAL IP
      - WG_MTU=1398
    volumes:
      - ./wireguard:/etc/wireguard
    ports:
      - "51820:51820/udp" # Change VPN port if needed
      - "51821:51821/tcp" # Web
    sysctls:
      - net.ipv4.ip_forward=1
      - net.ipv4.conf.all.src_valid_mark=1
    networks:
      adwireguard:
        ipv4_address: 10.8.2.2

  adguardhome:
    image: adguard/adguardhome
    container_name: adguardhome
    # For DHCP it is recommended to remove these ports and instead add: network_mode: "host"
    restart: always
    ports:
      # DNS Ports
      - "54:53/tcp"
      - "54:53/udp"
      # Dashboard
      - "3000:3000/tcp"
    environment:
      - TZ=Europe/Paris
    volumes:
      - ./adguard/work:/opt/adguardhome/work
      - ./adguard/conf:/opt/adguardhome/conf
    networks:
      adwireguard:
        ipv4_address: 10.8.2.3
```