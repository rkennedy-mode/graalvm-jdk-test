FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk-headless ca-certificates-java curl

RUN curl -sL https://github.com/oracle/graal/releases/download/vm-1.0.0-rc6/graalvm-ce-1.0.0-rc6-linux-amd64.tar.gz -o /tmp/graalvm1rc6.tar.gz
RUN tar -xzC /opt -f /tmp/graalvm1rc6.tar.gz

RUN curl -sL https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.0.0.2/graalvm-ce-java17-linux-amd64-22.0.0.2.tar.gz -o /tmp/graalvm22.tar.gz
RUN echo 4f743e0ed3d974b7d619ca2ed6014554e8c12e5ebbb38b9bc9e820b182169bd4 /tmp/graalvm22.tar.gz | sha256sum --check
RUN tar -xzC /opt -f /tmp/graalvm22.tar.gz

RUN cp /etc/ssl/certs/java/cacerts /opt/graalvm-ce-1.0.0-rc6/jre/lib/security/cacerts

COPY . /app
WORKDIR /app

RUN JAVA_HOME=/opt/graalvm-ce-1.0.0-rc6 ./mvnw -P oldgraal clean package \
    && cp target/graalvm-jdk-test-1.0-SNAPSHOT.jar oldgraal.jar
RUN JAVA_HOME=/opt/graalvm-ce-java17-22.0.0.2 ./mvnw -P newgraal clean package \
    && cp target/graalvm-jdk-test-1.0-SNAPSHOT.jar newgraal.jar
RUN JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 ./mvnw -P openjdk-oldgraal clean package \
    && cp target/graalvm-jdk-test-1.0-SNAPSHOT.jar openjdk-oldgraal.jar
RUN JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 ./mvnw -P openjdk-newgraal clean package \
    && cp target/graalvm-jdk-test-1.0-SNAPSHOT.jar openjdk-newgraal.jar

ENTRYPOINT /bin/bash
