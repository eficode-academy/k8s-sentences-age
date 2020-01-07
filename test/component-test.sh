#! /bin/bash
docker_username=$docker_username docker-compose -p ci up --exit-code-from sut --build