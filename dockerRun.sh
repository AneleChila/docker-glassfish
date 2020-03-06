#!/bin/bash

docker build -t wigroup/glassfish3 .

docker run -d -m 2GB -p 4848:4848 -p 8080:8080 -p 8181:8181 -p 9009:9009 -e GLASSFISH_PASS="password" --name glassfish3 wigroup/glassfish3
