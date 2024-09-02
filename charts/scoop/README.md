## Introduction
 Scoop is a feature of Devtron designed to enhance the management and monitoring of Kubernetes clusters. Its primary use cases include:
 - **Monitoring Pod Restarts**: Track and view details of application pod restarts, including information on pods, restart events, previous container logs, and node status.
 - **Event Tracking**: Observe and act on events across all Kubernetes resources in the cluster.
 - **Resource Caching**: Cache Kubernetes resources in the target cluster to reduce API fetch times when accessing resources from the browser.

The following table lists the configurable parameters of the template Helm chart and their default values.

| Parameter                  | Description                                     | Default                                                    |
| -----------------------    | ---------------------------------------------   | ---------------------------------------------------------- |
| `scoop.image`         | Image of the scoop                               | `devtroninc.azurecr.io/scoop:187a41b0-629-25109`                                 |
| `scoop.imagePullSecrets.existingImagePullSecret`                | ImagePullsecret of the scoop Image                                 | ` `                                                     |
| `image.pullPolicy`         | Image pull policy                               | `Always` |
| `scoopNamespace`   | Namespace where scoop will be delpoyed |    |
| `env.CLUSTER_ID`         |  The ID of the target cluster where Scoop will be implemented  |         |
| `env.ORCHESTRATOR_URL`             | scoop will use this url to send the events , and that will be available in k8s watcher|  |
| `env.TOKEN`             |  It will be used to authenticate while sending the events to the orchestrator| ``                                                 |
| `env.CACHED_NAMESPACE`             |  storing the cache of specified namespaces.  | ` it will store the cache of all the namespaces`   
| `env.RETENTION`             |  Period for which cache will be stored ( in seconds)  | ``  
| `service.type`             | Kubernetes service type exposing port                  | `ClusterIP`                                                 |
| `service.port`             | TCP Port for this service                       |        80                                    |



