# =================================== updated ubuntu ==============================================
FROM ubuntu:18.04 AS ub-base

# Run the command inside your image filesystem.
RUN apt update

# graalvm native building libs
RUN apt-get -y install libasound2-dev libavcodec-dev libavformat-dev libavutil-dev libfreetype6-dev libgl-dev libglib2.0-dev libgtk-3-dev libpango1.0-dev libx11-dev libxtst-dev zlib1g-dev maven gcc libgtk-3-dev libxtst-dev

# android cross compiling libs
RUN apt -y install android-sdk

# clojure
WORKDIR /usr/tmp
RUN curl -O https://download.clojure.org/install/linux-install-1.10.1.536.sh &&\
    chmod +x linux-install-1.10.1.536.sh &&\
    ./linux-install-1.10.1.536.sh &&\
    clojure -?

# Set the working directory.
WORKDIR /usr/src/app

# Copy the file from your host to your current location.
COPY graalvm-ce /opt/graal
COPY graalvm-ce/lib /lib64
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

# =================================== ubuntu runner ==============================================
FROM ubuntu:18.04 AS ub-runner

WORKDIR /usr/src/app

COPY --from=ub-base /usr/src/app/target/client/x86_64-linux/helloWorld .

CMD [ "./helloWorld" ]
