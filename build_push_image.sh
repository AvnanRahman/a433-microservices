#Variable
DOCKER_HUB_IMG="hiroominan/item-app"
LOCAL_IMG="item-app"
TAG="v1"

#Remove Previous Build
docker rmi $LOCAL_IMG:$TAG

#Build image
cd ~/proyek-pertama
sudo docker build -t $LOCAL_IMG:$TAG .
#See list images
docker images
#Memberi nama baru ke image/tag
docker image tag $LOCAL_IMG:$TAG $DOCKER_HUB_IMG:$TAG

#login ke docker hub
cat ~/proyek-pertama/docker_token.txt | docker login -u hiroominan --password-stdin
#push image ke docker hub
docker push $DOCKER_HUB_IMG:$TAG
