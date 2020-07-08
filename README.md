# building slim size
docker build --tag graal .

## building full size
docker build -f Dockerfile-full --tag graal .

## run the container
docker run -it graal:latest

## debug the container with command
docker run -it graal:latest /bin/bash
