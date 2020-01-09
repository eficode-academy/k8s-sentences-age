#! /bin/bash
[[ -z "${docker_username}" ]] && DockerRepo='' || DockerRepo="${docker_username}/"
docker_username=$DockerRepo docker-compose -p ci up --build --exit-code-from sut