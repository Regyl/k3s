#!/bin/bash
docker compose down
pid=$!
wait $pid

docker rmi regyl/yagfi-front:latest
pid=$!
wait $pid

docker rmi regyl/yagfi-back:latest
pid=$!
wait $pid

docker compose up -d

echo "Started"
