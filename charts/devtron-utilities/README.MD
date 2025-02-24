### Devtron-Utilities
**Purpose**: Operational utilities, like load balancer controllers and autoscaling components, manage critical infrastructure resources.
**Includes**:  
- ingress-nginx
- cluster-autoscaler
- karpenter
- aws-load-balancer-controller
- aws-node-termination-handler
- minio 
- kcert
- argocd-certificate-refresh
- k8s-shield
- devtron-backups
- devtron-generic-helm
- holmes


## Installation  

To install a specific chart, use:  
```sh
helm repo add devtron https://helm.devtron.ai/
helm repo update devtron
helm install devtron-utilities-stack devtron/devtron-utilities --create-namespace -n utils
```
