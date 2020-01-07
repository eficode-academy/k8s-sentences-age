#! /bin/bash
USERN=$usern docker-compose -p ci up --exit-code-from sut --build