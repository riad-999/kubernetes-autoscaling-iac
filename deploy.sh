#!/bin/bash

# for autoscaling 
microk8s enable metrics-server
# for service name resolution
microk8s enable dns

echo "[--- Deploying redis ---]" 
# Redis Deployment 
# Redis main 
microk8s kubectl apply -f redis-main-deployment.yaml
microk8s kubectl apply -f redis-main-service.yaml
# Redis replica
# sleep 15 seconds to let redis main start up for the replicas to connect 
sleep 15
microk8s kubectl apply -f redis-replica-deployment.yaml
microk8s kubectl apply -f redis-replica-service.yaml

echo "[--- Deploying node app ---]" 
# Node app deployment
microk8s kubectl apply -f node-deployment.yaml
microk8s kubectl apply -f node-service.yaml
# expose node server on port 8080 of the host machine
sleep 15
microk8s kubectl port-forward service/node-service 8080:80 &

echo "[--- deploying react ---]" 
# React frontend deployment 
microk8s kubectl apply -f react-deployment.yaml
microk8s kubectl apply -f react-service.yaml
# expose react app on port 80 of the host machine
sleep 30
microk8s kubectl port-forward service/react-service 80:80 &

# Prometheus deployment
echo "[---Deployment prometheus---]" 
microk8s kubectl apply -f prometheus-config.yaml
microk8s kubectl apply -f prometheus-deployment.yaml
microk8s kubectl apply -f prometheus-service.yaml

# Grafana deployment 
echo "[--- Deploying grafana ---]" 
microk8s kubectl apply -f grafana-config.yaml
microk8s kubectl apply -f grafana-deployment.yaml
microk8s kubectl apply -f grafana-service.yaml
# expose grafana on port 3000 of the host machine
sleep 15
microk8s kubectl port-forward service/grafana 3000:3000 &

sleep 2

# deployment done
echo "[--- Deployment done ---]"
echo "[--- Web app at http://localhost ---]"  
echo "[--- Grafana at http://localhost:3000 ---]"  
