# Setup k3s
````
curl -sfL https://get.k3s.io | sh -
````

# Dashboard

# For docker-compose
````
curl -L https://github.com/kubernetes/kompose/releases/download/v1.26.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose
````
[HowToUse](https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/)
