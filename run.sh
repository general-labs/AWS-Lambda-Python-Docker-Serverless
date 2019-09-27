#!/bin/bash
docker rm serverless -f
docker rmi serverless
docker-compose up -d
docker-compose exec serverless /bin/bash
