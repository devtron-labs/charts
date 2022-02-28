[![Join Discord](https://img.shields.io/badge/Join%20us%20on-Discord-e01563.svg)](https://discord.gg/72JDKy4)

# Devtron Charts

Devtron is an open source software delivery workflow for kubernetes written in go. It is designed as a self-serve platform for operationalizing and maintaining applications (AppOps) on Kubernetes in a developer friendly way.

## Introduction

These chart bootstraps deployment of all required components for installation of [Devtron Platform](https://github.com/devtron-labs) on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It packages third party components like

- [Grafana](https://github.com/grafana/grafana) for displaying application metrics
- [Kube Prometheus](https://github.com/prometheus-operator/kube-prometheus) for Monitoring
- [Argocd](https://github.com/argoproj/argo-cd/) for GitOps
- [Argo Workflows](https://github.com/argoproj/argo) for CI
- [Clair](https://github.com/quay/clair) & [Guard](https://github.com/guard/guard) for Image Scanning
- [Kubernetes External Secrets](https://github.com/godaddy/kubernetes-external-secrets) for integrating with external secret management stores like [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/) or [HashiCorp Vault](https://www.vaultproject.io/)
- [Nats](https://github.com/nats-io) for event streaming
- [Postgres](https://github.com/postgres/postgres) as datastore
- Fork of [Argo Rollout](https://github.com/argoproj/argo-rollouts)
- [Kubewatch](https://github.com/bitnami-labs/kubewatch) a Kubernetes watcher that currently publishes notification to available collaboration hubs/notification channels
- [Calico Networking](https://github.com/projectcalico/calico) for networking and network security
- [Dgraph](https://github.com/dgraph-io/charts) as a distributed graph database
- [Coralogix](https://github.com/coralogix/fluentd-coralogix-image) for log collection, real time insights and trend analysis
- [AWS SSM Agent](https://github.com/aws/amazon-ssm-agent)

## How to use the charts

### Install with Helm

These charts are currently not available on the official helm repository therefore you need to download it to install.

```bash
helm repo add devtron http://helm.devtron.ai
helm install Chart-Release-Name devtron/chartName
```

Here `chartName` is the folder name for which you want to install the particular chart, and `Chart-Release-Name` is the release name that you can provide.

Each Chart also has a seperate Readme file to understand the usage in Devtron.
