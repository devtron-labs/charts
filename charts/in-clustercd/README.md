## Introduction

This helm chart to install devtron agent on target/application cluster by which we can run post/pre deployment pods on target/application cluster which are added on devtron cluster.

or 

Devtron helm chart to deploy In-cluster to run the post and pre deployment devtron agents on apllication cluster, not on devtron cluster

##Prerequisites

# 1. Install `migration-incluster-cd` helm chart on devtron cluster for particular target cluster.


`migration-incluster-cd` helm chart enable `Execute in application Environment` during post/pre deployment for target cluster on devtron UI.

## Note:- `migration-incluster-cd` should be install on devtron-cluster

### Install `migration-incluster-cd ` with Helm 

Run the following command to install the latest version of incluster migration integration:

```bash
helm repo add devtron https://helm.devtron.ai 

helm install incluster-migration devtron/migration-incluster-cd \
--namespace devtroncd \
--set cluster_name=prod-eks --set postgres_auth.secretName=devtron-secret
```

Here `cluster_name` is prod-eks , this cluster name should be added on devtron cluster .

# 2. Install `in-clustercd` helm chart on target cluster (this one).

# 3. Put ORCH_HOST key value pair in `devtron-cm` and bounce the devtron pod

# Note:- There must be connectivity from target cluster to devtron cluster.

ORCH_HOST: http://test.devtron.com/orchestrator/webhook/msg/nats

Put ORCH_HOST value same as of `CD_EXTERNAL_LISTENER_URL` value which is passed in values.yaml .

# 4. Try to run post/pre deploymnet after enable `Execute in application Environment` for an environment of target cluster.