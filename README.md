# Download graal
Download the latest release: https://github.com/graalvm/graalvm-ce-dev-builds/releases
unpack and place to graalvm-ce

# building slim size
docker build --tag graal .

## building full size
docker build -f Dockerfile-full --tag graal .

## run the container
docker run -it graal:latest

## debug the container with command
docker run -it graal:latest /bin/bash
