#!/bin/bash

docker push "$docker_username/age:1.0"  &

wait
