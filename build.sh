#!/usr/bin/env bash
set -eu
versions=$(curl https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-parent/ |\
    cut -d'"' -f2 | \
    grep '/$' | tr -d / |\
    grep '^2' \
)
for SPRING in $versions; do
    echo $SPRING
    docker build --tag rzymek/spring-boot-build:$SPRING --build-arg SPRING=$SPRING .
done
for SPRING in $versions; do
    docker push rzymek/spring-boot-build:$SPRING
done
