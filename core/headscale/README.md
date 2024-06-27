1- Prepare a directory on the host Docker node in your directory of choice, used to hold headscale configuration and the SQLite database:
mkdir -p ./headscale/config
cd ./headscale

2- Create an empty SQlite datebase in the headscale directory:
touch ./config/db.sqlite

3- (Strongly Recommended) Download a copy of the example configuration from the headscale repository.
wget -O ./config/config.yaml https://raw.githubusercontent.com/juanfont/headscale/main/config-example.yaml

Modify the config file to your preferences before launching Docker container. Here are some settings that you likely want:
nano ./config/config.yaml

```sh
# Change to your hostname or host IP
server_url: http://your-host-name:8080
# Listen to 0.0.0.0 so it's accessible outside the container
metrics_listen_addr: 0.0.0.0:9090
# The default /var/lib/headscale path is not writable in the container
noise:
  private_key_path: /etc/headscale/noise_private.key
# The default /var/lib/headscale path is not writable in the container
derp:
  private_key_path: /etc/headscale/private.key
# The default /var/run/headscale path is not writable  in the container
unix_socket: /etc/headscale/headscale.sock
# The default /var/lib/headscale path is not writable  in the container
database.type: sqlite3
database.sqlite.path: /etc/headscale/db.sqlite
```

4- Create a docker compose file and paste the following:
touch docker-compose.yaml

5- Verify headscale is running: Follow the container logs:
docker logs --follow headscale

6- Verify headscale is available:
curl http://127.0.0.1:9090/metrics

