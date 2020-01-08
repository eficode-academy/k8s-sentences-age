#!/bin/bash
docker build -t "$docker_username/age:latest" -t "$docker_username/age:1.0-${GITHUB_SHA::4}" ./app
