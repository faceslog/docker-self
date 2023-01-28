*Docker CLI Cheatsheet by @faceslog*
# Docker CLI Utils

## Manage Containers & Images

Build and image with the name image-name in the current directory require the DockerFile
```sh
docker build -t [image-name] .
```

Run the given image in the foreground, use `-d` to run in the background
```sh
docker run [image-name]

# Background:
docker run [image-name] -d
```

Map a local directory to the container
```sh
docker run -v [HOSTDIR]:[CONTAINERDIR] [CONTAINER-NAME]
```

Map a port to the container
```sh
docker run -p [HOSTPORT]:[CONTAINERPORT] [CONTAINER-NAME]
```

Rename a container:
```sh
docker rename [old-container-name] [new-name]
```

Copy a file from the host to the container (bidirectional)
```sh
# ex: docker cp index.html web:/index.html
docker cp [Host-Path-File] [Container-Src]

# work from container to the host
docker cp [Container-Src] [Host-Path-File] 
```

Delete an image:
```sh
docker image rm [image-name]

# Delete all existing images
docker image rm $(docker images -a -q)
```
Start / Stop / Restart a container
```sh
docker [stop | start | restart] [container-name]

# To apply it to all containers
docker [stop | start | restart] $(docker ps -a -q)
```

Delete a container if stopped, `-f` to force delete the container even if running
```sh
docker rm [container-name]

# Delete running container
docker rm -f [container-name]
```

Update all containers:
```sh
# Pull latest images
sudo docker images |grep -v REPOSITORY|awk '{print $1}'|sudo xargs -L1 docker pull

# Restart all containers
docker restart $(docker ps -a -q)

# Delete old images
docker image prune -a
```

## Infos & Stats

Show mapped ports of a container
```sh
docker port [container-name]
```
Show processes running in the container
```sh
docker top [container-name]
```
Show all modified files in the container
```sh
docker diff [container-name]
```
Display logs of a container
```sh
docker logs [container-name]
```
List all local images
```sh
docker image ls
```
List all existing containers currently running, `-a` as option to see all containers even those stopped
```sh
docker ps

# To see all containers even those stopped
docker ps -all
```


## Docker Compose

Create and run the container specified in the docker-compose file
```sh
# Run in the foreground
docker-compose up 

# Run in the background
docker-compose up -d
```

List all running containers and all containers with option `-all`:
```sh
docker-compose ps

# All containers even those stopped same as -all
docker-compose ps -a
```
Pull images define in the compose file
```sh
docker-compose pull
```
Stop and remove containers created by up
```sh
docker-compose down
```
Update all Docker Containers with docker-compose this command will cd into each directory and then run a command to fetch the latest images and restart the containers if there is an update. It makes the assumption that you have a directory per service with a docker-compose file within.
```sh
for d in ./*/ ; do (cd "$d" && sudo docker-compose pull && sudo docker-compose --compatibility up -d); done
```

## Cleaning your containers 

This will remove:

- all stopped containers
- all networks not used by at least one container
- all dangling images
- all dangling build cache

```sh
docker system prune 

# If you wanted to include unused images & volumes in this, then use this command:
docker system prune --all --volumes
```
Remove all images without at least one container associated with them.
```sh
docker image prune -a 

# Same for volumes
docker volume prune

# Same for networks
docker network prune
```