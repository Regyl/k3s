k3s kubectl create -f postgres-configmap.yaml
sleep 2 
k3s kubectl create -f postgres-storage.yaml
sleep 2 
k3s kubectl create -f postgres-deployment.yaml
sleep 2 
k3s kubectl create -f postgres-service.yaml
sleep 2
