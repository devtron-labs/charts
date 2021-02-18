# Coralogix Fluentd Helm chart for Kubernetes

It's a modificated version of official `FluentD` image with support of integration with *Coralogix*, multiprocessing and K8S.

## Introduction

This chart bootstraps a [FluentD Coralogix](https://github.com/coralogix/fluentd-coralogix-image) daemonset on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- `Kubernetes` 1.6+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release \
  --set PRIVATE_KEY=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX \
  --set APP_NAME=your-app-name \
  --set SUB_SYSTEM=sub-system-name
    stable/fluentd-coralogix
```

The command deploys *Fluentd-Coralogix* on the `Kubernetes` cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the `Kubernetes` components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the `Fluentd Coralogix` chart and their default values.

| Parameter                                  | Description                                                                                                    | Default                                        |
|--------------------------------------------|----------------------------------------------------------------------------------------------------------------|------------------------------------------------|
| `PRIVATE_KEY`                              | Coralogix Private Key                                                                                          | `XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX`         |
| `APP_NAME`                                 | Coralogix Application Name                                                                                     | `$kubernetes.namespace_name`                   |
| `SUB_SYSTEM`                               | Coralogix Subsystem name                                                                                       | `$kubernetes.container_name`                   |
| `coralogix.log_key_name`                   | Name of field in record which will be sent to Coralogix                                                        | None                                           |
| `coralogix.timestamp_key_name`             | Field with will be used in Coralogix as timestamp of log record                                                | None                                           |
| `coralogix.is_json`                        | Convert data to JSON                                                                                           | `true`                                         |
| `coralogix.force_compression`              | Compress data                                                                                                  | `false`                                        |
| `coralogix.debug`                  | Enable debug mode                                                                                                      | `false`                                        |
| `coralogix.proxy.host`             | Proxy host                                                                                                            | `None`                                         |
| `coralogix.proxy.port`             | Proxy port                                                                                                            | `None`                                         |
| `coralogix.proxy.user`             | Proxy user                                                                                                            | `None`                                         |
| `coralogix.proxy.password`         | Proxy password                                                                                                        | `None`                                         |
| `container.image.repository`               | Image repository                                                                                               | `docker.io/coralogixrepo/fluentd-coralogix-image` |
| `container.image.tag`                      | Image tag                                                                                                      | `1.1.6`                                        |
| `container.image.pullPolicy`       | Image pull policy                                                                                                      | `Always`                                       |
| `container.resources.limits.cpu`           | CPU resource limits                                                                                            | `100m`                                         |
| `container.resources.limits.memory`        | Memory resource limits                                                                                         | `400Mi`                                        |
| `container.resources.requests.cpu`         | CPU resource requests                                                                                          | `100m`                                         |
| `container.resources.requests.memory`      | Memory resource requests                                                                                       | `400Mi`                                        |
| `rbac.create`                      | If `true`, create and use RBAC resources                                                                               | `false`                                        |
| `tolerations`                              | List of node taints to tolerate (requires Kubernetes >= 1.6)                                                   | `node-role.kubernetes.io/master`: `NoSchedule` |
| `service.fluentd.enabled`                  | Enable FluentD forward service                                                                                 | `true`                                         |
| `service.fluentd.port`                     | FluentD port                                                                                                   | `24224`                                        |
| `service.http.enabled`                     | Enable HTTP collector service                                                                                  | `true`                                         |
| `service.http.port`                        | HTTP port                                                                                                      | `9880`                                         |
| `service.syslog.enabled`                   | Enable Syslog collector service                                                                                | `true`                                         |
| `service.syslog.port`                      | Syslog port                                                                                                    | `5140`                                         |
| `service.graylog.enabled`                  | Enable Graylog collector service                                                                               | `true`                                         |
| `service.graylog.port`                     | Graylog port                                                                                                   | `12201`                                        |
| `service.clusterIP`                        | ClusterIP for service enabled                                                                                  | `None`                                         |


### RBAC

By default the chart will not install the associated RBAC rolebinding,
using beta annotations.

To determine if your cluster supports this running the following:

```console
$ kubectl api-versions | grep rbac
```

You also need to have the following parameter on the api server. See the
following document for how to enable [RBAC](https://kubernetes.io/docs/admin/authorization/rbac/).

```
--authorization-mode=RBAC
```

If the output contains `"beta"` or both `"alpha"` and `"beta"` you can enable RBAC.

### Enable RBAC role/rolebinding creation

To enable the creation of RBAC resources, do the following:

```console
$ helm install --name my-release stable/fluentd-coralogix --set rbac.create=true ...
```
