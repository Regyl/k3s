[Installation&Usage guide](https://severalnines.com/database-blog/using-kubernetes-deploy-postgresql)

````
k3s kubectl create -f postgres-configmap.yaml 
k3s kubectl create -f postgres-storage.yaml 
k3s kubectl create -f postgres-deployment.yaml 
k3s kubectl create -f postgres-service.yaml
````
