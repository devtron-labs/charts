### Devtron-Monitoring  
**Purpose**: Monitoring and logging components.  
**Includes**:  
- Fluent-Bit / Vector Logs  
- Uptime Kuma  
- Jaeger  
- Metrics Server  
- Kube-Prom-Stack / Victoria Metrics  
- Black Box  
- Event Logger  



## Installation  

To install a specific chart, use:  
```sh
helm repo add devtron https://helm.devtron.ai/
helm repo update devtron
helm install devtron-monitoring-stack devtron/devtron-monitoring --create-namespace -n monitoring
```
