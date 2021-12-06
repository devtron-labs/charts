# cluster-essentials Helm Chart

This is a chart to install almost all the infra essentials that a kubernetes cluser needs, it has the following charts
- [metrics-server](https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server)
- [cluster-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/charts/cluster-autoscaler)
- [argo-rollout](https://github.com/devtron-labs/charts/tree/main/charts/rollout)
- [keda](https://github.com/kedacore/charts/tree/master/keda)
- [kubernetes-event-exporter](https://github.com/bitnami/charts/tree/master/bitnami/kubernetes-event-exporter)
- [aws-load-balancer-controller](https://github.com/aws/eks-charts/tree/master/stable/aws-load-balancer-controller)
- [kube-prometheus-stack](https://github.com/devtron-labs/charts/tree/main/charts/kube-prometheus-stack)

## Get Repo Info

```console
helm repo add devtron https://helm.devtron.ai
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

```console
helm install [RELEASE_NAME] devtron/cluster-essentials [flags]
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] devtron/cluster-essentials [flags]
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

### Migrating from stable/kube-state-metrics and kubernetes/kube-state-metrics

You can upgrade in-place:

1. [get repo info](#get-repo-info)
1. [upgrade](#upgrading-chart) your existing release name using the new chart repo


## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments:

```console
helm show values devtron/cluster-essentials
```

You may also run `helm show values` on this chart's [dependencies](#dependencies) for additional options.
