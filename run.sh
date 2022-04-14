#!/bin/sh

echo oldgraal
/opt/graalvm-ce-1.0.0-rc6/bin/java -jar oldgraal.jar

echo newgraal
/opt/graalvm-ce-java17-22.0.0.2/bin/java -jar newgraal.jar

echo openjdk oldgraal
/usr/lib/jvm/java-8-openjdk-amd64/bin/java -jar openjdk-oldgraal.jar

echo openjdk newgraal
/usr/lib/jvm/java-8-openjdk-amd64/bin/java -jar openjdk-newgraal.jar
