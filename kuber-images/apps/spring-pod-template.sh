#!/bin/bash

APPNAME=$1
PORT=$2

if [[ -z "$APPNAME" || -z "$PORT" ]]
	then echo "Parameter appname and/or port not set. Exiting..."
	exit 1
fi

# Pod & service template
rm -f "$APPNAME.yaml"
touch "$APPNAME.yaml"
cat > "$APPNAME.yaml" << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: yasn-cloud-config
spec:
  selector:
    matchLabels:
      app: $APPNAME
  replicas: 1 #Pods quantity for one deployment
  template:
    metadata:
      labels:
        app: $APPNAME
        visualize: "true"
    spec:
      containers:
      - name: $APPNAME
        image: regyl/$APPNAME #Docker image
        ports:
        - containerPort: $PORT
---
apiVersion: v1
kind: Service
metadata:
  labels:
    visualize: "true"
  name: $APPNAME-service
spec:
  selector:
    app: $APPNAME
  ports:
  - name: http
    protocol: TCP
    port: $PORT
    targetPort: $PORT
  type: ClusterIP
EOF

firewall-cmd --add-port="$PORT"/tcp
k3s kubectl apply -f "$APPNAME.yaml"
echo 'Something like Happy Helming :D'
