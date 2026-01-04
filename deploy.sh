#!/bin/bash
set -e

echo "Deploying application using docker-compose..."

docker-compose down
docker-compose up -d

echo "Deployment completed."

