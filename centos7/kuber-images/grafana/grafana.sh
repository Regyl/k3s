k3s kubectl apply -f grafana.yaml
sleep 20
k3s kubectl port-forward service/grafana 3000:3000
echo "Go to the <IPv4>:3000. Login: admin, password: admin"
