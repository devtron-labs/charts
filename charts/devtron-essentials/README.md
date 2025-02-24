### Devtron-Essentials
**Purpose**: Essential components for Devtron application deployments, including Argo CD, Rollouts, Workflows, and supporting services.
**Includes**:  
- argo-cd
- argo-rollouts
- argo-workflow
- devtron-generic-helm
- postgresql
- rollout 

## Installation  

To install a specific chart, use:  
```sh
helm repo add devtron https://helm.devtron.ai/
helm repo update devtron
helm install devtron-utilities-stack devtron/devtron-essentials --create-namespace -n devtroncd
```
