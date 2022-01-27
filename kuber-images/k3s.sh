echo "1. Install clear k3s"
curl -sfL https://get.k3s.io | sh -
sleep 30
k3s kubectl get all

echo "2. Install k3s-dashboard"
./k3s-dashboard/k3s-dashboard.sh
pid=$!
wait $pid

echo "3. Install Grafana"
./grafana/grafana.sh
pid=$!
wait $pid

echo "4. Install Loki"
./grafana/loki/loki.sh
