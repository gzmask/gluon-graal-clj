# Download graal
Download the latest release: https://github.com/graalvm/graalvm-ce-dev-builds/releases
unpack and place to graalvm-ce

# building slim size
docker build --target ub-base -t graal-build .
docker build --target ub-runner -t graal-run .

## run the container
docker run -it graal-run:latest

## debug the builder with command
docker run -it graal-build:latest /bin/bash
