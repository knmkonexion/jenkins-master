#!/bin/bash

clear

# CLUSTER_NAME='jenkins'
# k3d cluster create $CLUSTER_NAME --api-port 6551 -p "8090:80@loadbalancer" --agents 2
# export KUBECONFIG="$(k3d kubeconfig write k3s-jenkins)"

#----------
# WORKING
#----------
# NOTES: Deploys to namespace from single file
# can break the namespace yaml up if desired...will just need to change namespaces to deploy content(s)
#----------
# k3d cluster delete web-cluster
# k3d cluster create web-cluster --api-port 6551 -p "8090:80@loadbalancer" --agents 1
# kubectl apply -f k8s/dev-nginx.yaml

#----------
# WORKING
#----------
# NOTES: Deploys Jenkins with persistent/node/cluster mount points
# this is for local development only, not a good habit for prod workloads
#----------
k3d cluster delete jenkins
k3d cluster create jenkins --api-port 6550 -p "8080:80@loadbalancer" -v /mnt/d/k8s_datastore:/k3d_datastore -v /var/run/docker.sock:/var/run/docker.sock --agents 1
kubectl apply -f k8s/jenkins.yaml
