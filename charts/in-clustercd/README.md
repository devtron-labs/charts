## Introduction

This helm chart to install devtron agent on target/application cluster by which we can run post/pre deployment pods on target/application cluster which are added on devtron cluster.

or 

Devtron helm chart to deploy In-cluster to run the post and pre deployment devtron agents on apllication cluster, not on devtron cluster

##Prerequisite

# 1. Install incluster migration helm chart on devtron cluster for particular target cluster.

## Introduction 

incluster migration helm chart enable `Execute in application Environment` during post/pre deployment for target cluster on devtron UI.



### Install with Helm

Run the following command to install the latest version of incluster migration integration:

```bash
helm repo add devtron https://helm.devtron.ai 

helm install incluster-migration devtron/migration-incluster-cd \
 --namespace devtroncd \
--set cluster_name=prod-eks --set postgres_auth.secretName=devtron-secret
```

Here `cluster_name` is prod-eks , this cluster name should be added on devtron cluster .

# 2. Install incluster helm chart this chart should be install on target cluster.