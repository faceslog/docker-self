## Enable ip v6

Edit or add `daemon.json`: 

```sh
nano /etc/docker/daemon.json
```

```json
{
  "ipv6": true,
  "fixed-cidr-v6": "fdd1:b20:b00b::1/48",
  "experimental": true,
  "ip6tables": true
}
```

Save the file !

Restart docker and reboot server:

```sh
sudo systemctl restart docker
sudo reboot now
```

To check the gateway was added

```sh
docker network inspect bridge
```

Create a new docker network with the following proprety for IPv6:

Driver: `bridge`
Subnet: `fdd1:b19:abc1::/48`
Gateaway: `fdd1:b19:abc1::1`

Create a new IPv6 bridge network with the following command:
```sh
docker network create --subnet="<your-v6-prefix>" \
--gateway="your-gateway-address" \
--ipv6 \
<name-of-bridge-network>
```

Example:
```sh
docker network create --subnet="fdd1:b19:abc1::/48" \
--gateway="fdd1:b19:abc1::1" \
--ipv6 \
dockernet

# Create and attach a container to our network:
docker run -di --name alpine-1 \
    --network dockernet \
    alpine:latest

# Verify
docker network inspect dockernet
```