## Introduction

Helm chart to enable `Execute in environment` for a target cluster , which is added on devtron UI.

This helm chart create a k8s job which connect with devtron postgres and run sql query for target cluster in orchestrator database.

## Note:- This helm chart should be install on devtron cluster.

### Install with Helm

Run the following command to install the latest version of incluster migration integration:

```bash
helm repo add devtron https://helm.devtron.ai 

helm install incluster-migration devtron/migration-incluster-cd \
--namespace devtroncd \
--set cluster_name=XXXXX --set postgres_auth.secretName=devtron-secret
```

Here put `cluster_name` for which we are enabling `Execute in environment` this cluster name should be added on devtron cluster .

