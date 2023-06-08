# Need of this Chart 
While onboarding **Devtron** there are some essentials and required charts which are need to deployed on the cluster to use Devtron efficiently. So you can deployed this chart in one go. It will remove the extra efforts of deploying multiple charts. You just have to enable and disable the required chart which you want to deploy.

## Here are the list of charts Devtron essentials chart contain:-

* argo-rollouts controller
* keda
* winter-soldier
* in-clustercd
* metrics-server
* ESO operator
* ALB ingress controller
* CSI driver
* flagger controller
* kyverno
* clair
* postgres
* cluster autoscaler
* nginx ingress
* argo workflow

## How to install this chart
1. Fetch all the charts 

```
helm dependency up
```
2. Get the template 
```
helm template --debug --dry-run <path-of-chart>
```

3. To install this chart

```
cd to helm chart directory
```

```
helm install devtron-esssentials .
```



### **Note** :
If You enable in-cluster cd chart make sure you should create two namespace mention in values.yaml.
