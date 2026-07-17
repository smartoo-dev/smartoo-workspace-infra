#!/bin/bash
# Скрипт для принудительного восстановления прав на SSH-ключи внутри контейнера workspace-dev

CONTAINER_NAME="smartoo-workspace-dev"
USER_NAME="dev"
HOME_DIR="/home/dev"
PUB_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP+NmwLYur7FGNbPFwrUYsQrFoBTr7GRTjqmSkyi4KtI"

echo "🔧 Восстановление прав доступа для контейнера $CONTAINER_NAME..."

docker exec -it $CONTAINER_NAME mkdir -p $HOME_DIR/.ssh
docker exec -it $CONTAINER_NAME bash -c "echo \"$PUB_KEY\" > $HOME_DIR/.ssh/authorized_keys"

docker exec -it $CONTAINER_NAME chown -R $USER_NAME $HOME_DIR/.ssh
docker exec -it $CONTAINER_NAME chown $USER_NAME $HOME_DIR

docker exec -it $CONTAINER_NAME chmod 750 $HOME_DIR
docker exec -it $CONTAINER_NAME chmod 700 $HOME_DIR/.ssh
docker exec -it $CONTAINER_NAME chmod 600 $HOME_DIR/.ssh/authorized_keys

echo "🔄 Перезапуск контейнера..."
docker restart $CONTAINER_NAME

echo "✅ Готово! Порт открыт, права настроены. Попробуйте выполнить ssh code.smartoo.dev"
