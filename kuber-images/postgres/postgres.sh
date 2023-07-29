#!/bin/bash

DBNAME=$1
DBUSER=$2
DBPASSWORD=$3

if [[ -z "$DBNAME" || -z "$DBUSER" || -z "$DBPASSWORD"  ]]
	then echo "Required parameters not set"
	exit 1
fi
PG_VERSION=15.3
echo "Running default version $PG_VERSION"

rm -rf ./$DBNAME
mkdir $DBNAME

# Postgres configmap
cat > $DBNAME/$DBNAME-configmap.yaml << EOF 
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-config
  labels:
    app: $DBNAME
data:
  POSTGRES_DB: $DBNAME
  POSTGRES_USER: $DBUSER
  POSTGRES_PASSWORD: $DBPASSWORD
EOF

# Postgres PV/PVC
cat > $DBNAME/$DBNAME-storage.yaml << EOF
kind: PersistentVolume
apiVersion: v1
metadata:
  name: postgres-pv-volume
  labels:
    type: local
    app: $DBNAME
spec:
  storageClassName: manual
  capacity:
    storage: 50Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/data"
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: postgres-pv-claim
  labels:
    app: $DBNAME
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 50Gi
EOF

# Postgres deployment
cat > $DBNAME/$DBNAME-deployment.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: $DBNAME
    spec:
      containers:
        - name: $DBNAME
          image: postgres:$PG_VERSION
          imagePullPolicy: "IfNotPresent"
          ports:
            - containerPort: 5432
          envFrom:
            - configMapRef:
                name: postgres-config
          volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgredb
      volumes:
        - name: postgredb
          persistentVolumeClaim:
            claimName: postgres-pv-claim
  selector:
    matchLabels:
      app: $DBNAME
EOF


# Postgres service
cat > $DBNAME/$DBNAME-service.yaml << EOF
apiVersion: v1
kind: Service
metadata:
  name: postgres
  labels:
    app: $DBNAME
spec:
  type: NodePort
  ports:
    - name: http
      protocol: TCP
      port: 5432
      targetPort: 5432
  selector:
    app: $DBNAME
EOF

k3s kubectl apply -f $DBNAME
pid=$!
wait $pid

echo "Postgres published to kubernetes-cluster"
