#!/bin/bash

DATE=$(date +"%Y%m%d%H%M%S")
echo "Running Backup on $DATE"

# Chemin de base pour les sauvegardes
BACKUP_PATH="/opt/docker_backups"
# Chemin des volumes Docker
DOCKER_VOLUMES="/home/USER/core"

echo "Stopping Docker Containers"
# 1. Arrêt de tous les conteneurs Docker
docker stop $(docker ps -a -q)

# 2. Sauvegarde des volumes
# Création du dossier de sauvegarde s'il n'existe pas
mkdir -p "$BACKUP_PATH"

# Création de l'archive
tar czf "$BACKUP_PATH/backup_$DATE.tar.gz" -C "$DOCKER_VOLUMES" .

# 3. Conserver uniquement les 2 sauvegardes les plus récentes
# Suppression des autres sauvegardes, en ne conservant que les 2 plus récentes
ls -dt $BACKUP_PATH/* | tail -n +3 | xargs rm -f

echo "Backup saved restarting containers"
# 4. Redémarrage des conteneurs Docker
docker start $(docker ps -a -q)

echo "Containers Restarted"

# ADD A CRON JOB: crontab -e
# 0 3 * * * /opt/docker_local_backup.sh >> /var/log/docker_backup.log 2>&1