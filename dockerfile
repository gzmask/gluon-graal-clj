# Use the official image as a parent image.
FROM ubuntu:18.04

# Run the command inside your image filesystem.
RUN apt update
RUN apt-get -y install libasound2-dev libavcodec-dev libavformat-dev libavutil-dev libfreetype6-dev
RUN apt-get -y install libgl-dev libglib2.0-dev libgtk-3-dev libpango1.0-dev libx11-dev libxtst-dev zlib1g-dev
RUN apt-get -y install maven gcc
RUN apt-get -y install libgtk-3-dev libxtst-dev

# Set the working directory.
WORKDIR /usr/src/app

# Copy the file from your host to your current location.
COPY graalvm-ce-java11-20.1.0 /opt/graal
COPY graalvm-ce-java11-20.1.0/lib /lib64
COPY libstdc++.so /lib64/libstdc++.so

ENV GRAALVM_HOME /opt/graal
ENV JAVA_HOME /opt/graal
ENV PATH="/opt/graal/bin:${PATH}"
ENV PATH="/opt/graal/lib:${PATH}"


# Copy the rest of your app's source code from your host to your image filesystem.
COPY src ./src
COPY pom.xml .

RUN mvn clean client:build 
RUN mvn client:run

# Run the specified command within the container.
CMD [ "/usr/src/app/target/client/x86_64-linux/helloWorld" ]
