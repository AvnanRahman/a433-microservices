#!/bin/sh
# Set variable tentang images
image_name="order-service"
image_version="latest"
username_github="avnanrahman"
package_name="$username_github/$image_name:$image_version"

# Build docker image
echo -e "Building backend order-service images..."
docker build . -t $package_name

# Set tag baru untuk image yang telah di build
echo -e "Set image tag sesuai format GitHub Container Registry..."
docker tag $package_name ghcr.io/$package_name

# List available images
echo -e "Printing list of Docker Images..."
docker images

# Login ke github CR
echo -e "Login ke Github CR..."
docker login ghcr.io -u $username_github -p $GCR_TOKEN

# Push image ke github CR
echo -e "Push Image ke Github CR..."
docker push ghcr.io/$package_name

echo -e "\nDone."