#!/bin/bash

cp ../loyalty-server/target/loyalty-server-2.18.1.war ./docker-glassfish/loyalty-server-2.18.1.war

docker build -t wigroup/glassfish3 .

rm -rf ./docker-glassfish/loyalty-server-2.18.1.war

docker run -d -m 2GB -p 4848:4848 -p 8080:8080 -p 8181:8181 -p 9009:9009 -e GLASSFISH_PASS="password" --name glassfish3 wigroup/glassfish3