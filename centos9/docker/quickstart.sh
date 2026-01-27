#!/bin/bash
echo "Installing & starting docker..."

dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
pid=$!
wait $pid

dnf install docker-ce docker-ce-cli containerd.io
pid=$!
wait $pid

systemctl start docker
pid=$!
wait $pid

systemctl enable docker
pid=$!
wait $pid

systemctl status docker
pid=$!
wait $pid

echo "Finished!"