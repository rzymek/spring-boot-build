#!/usr/bin/env bash
set -eu
versions=$(curl https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-parent/ |\
    cut -d'"' -f2 | \
    grep '/$' | tr -d / |\
    grep '^2' \
)
prefix=rzymek/spring-boot-build
for SPRING in $versions; do
    echo $SPRING
    docker pull $prefix:$SPRING || docker build --tag $prefix:$SPRING --build-arg SPRING=$SPRING .
done
for SPRING in $versions; do
    docker push $prefix:$SPRING
done
