# Setup k3s
````
curl -sfL https://get.k3s.io | sh -
````

# Dashboard
1. Execute from file:
````
GITHUB_URL=https://github.com/kubernetes/dashboard/releases
VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
sudo k3s kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
````
2. Create and apply dashboard.admin-user.yml, dashboard.admin-user-role.yml
3. Change type: ClusterIP to NodePort. Remember field *ports/nodePort* value
````
k3s kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard
````
4. Obtain auth token
````
k3s kubectl -n kubernetes-dashboard describe secret admin-user-token | grep '^token'
````
5. Go to the *IP*:*ports/nodePort* and input the token
[Guide](https://blog.tekspace.io/deploying-kubernetes-dashboard-in-k3s-cluster/)


# Deploy Loki Stack (Loki, Promtail, Grafana, Prometheus)
````
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade --install loki grafana/loki-stack  --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false
````
2. Obtain auth token
````
kubectl get secret --namespace default loki-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
````
# For docker-compose
````
curl -L https://github.com/kubernetes/kompose/releases/download/v1.26.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose
````
[HowToUse](https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/)
