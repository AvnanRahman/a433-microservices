#Variable
IMAGE="hiroominan/microservices-proyek-pertama"
APP="item-app"

#Remove Previous Build
docker rmi $APP:v1

#Build image
cd ~/proyek-pertama
sudo docker build -t $APP:v1 .
#See list images
docker images
#Memberi nama baru ke image/tag
docker image tag $APP:v1 $IMAGE:v1

#login ke docker hub
cat ~/proyek-pertama/docker_token.txt | docker login -u hiroominan --password-stdin
#push image ke docker hub
docker push $IMAGE:v1
docker rmi $IMAGE:v1
