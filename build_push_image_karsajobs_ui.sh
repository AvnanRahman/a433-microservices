#!/bin/sh
# Set variable tentang images
image_name="karsajobs-ui"
image_version="latest"
username_github="afnanrahman"
package_name="$username_github/$image_name:$image_version"

# Build docker image
echo -e "Building frontend karsajobs-ui images..."
docker build -t . $package_name

# Set tag baru untuk image yang telah di build
echo -e "Set image tag sesuai format GitHub Container Registry..."
docker tag $package_name ghcr.io/$package_name

# List available images
echo -e "Printing list of Docker Images"
docker images

# Login ke github CR
docker login ghcr.io -u $username_github -p $GCR_TOKEN

# Push image ke github CR
docker push ghcr.io/$package_name

echo -e "\nDone."