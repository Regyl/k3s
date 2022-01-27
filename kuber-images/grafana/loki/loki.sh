export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
pid=$!
wait $pid
helm upgrade --install loki  grafana/loki -f loki.yaml
echo "Go to Grafana and put the next Loki's URL: http://loki:3100/"
