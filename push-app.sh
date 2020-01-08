#!/bin/bash

docker push "$docker_username/age:1.0-${GITHUB_SHA::4}" 
docker push "$docker_username/age:latest" &
wait