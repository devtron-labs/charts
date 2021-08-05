# NATS Streaming Clustering Helm Chart

Sets up a [NATS](http://nats.io/) Streaming server cluster with Raft based replication.

## Getting started

This chart relies on an already available NATS Service to which the
NATS Streaming nodes that will form a clusters can connect to.
You can install the NATS Operator and then use it to create a NATS cluster
via the following:

```console
$ kubectl apply -f https://raw.githubusercontent.com/nats-io/nats-operator/master/example/deployment-rbac.yaml
$ kubectl apply -f https://raw.githubusercontent.com/nats-io/nats-operator/master/example/example-nats-cluster.yaml
```

This will create a NATS cluster on the `nats-io` namespace.  Then, to
install a NATS Streaming cluster the URL to the NATS cluster can be
specified as follows (using `my-release` for a name label for the
cluster):

```console
$ git clone https://github.com/wallyqs/nats-streaming-cluster-chart nats-streaming-cluster
$ helm install nats-streaming -n my-release --set natsUrl=nats://nats.nats-io.svc.cluster.local:4222
```

This will create 3 follower nodes plus an extra Pod which is
configured to be in bootstrapping mode, which will start as the leader
of the Raft group as soon as it joins.

```console
$ kubectl get pods --namespace default -l "app=nats-streaming,release=my-release"
NAME                                          READY     STATUS    RESTARTS   AGE
my-release-nats-streaming-0           1/1       Running   0          30s
my-release-nats-streaming-1           1/1       Running   0          23s
my-release-nats-streaming-2           1/1       Running   0          17s
```

Note that in case the bootstrapping Pod fails then it will not be
recreated and instead one of the extra follower Pods will take over
the leadership.  The follower Pods are part of a Deployment so those
in case of failure they will be recreated.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the
chart and deletes the release.

## Configuration

| Parameter                            | Description                                                                                  | Default                                |
| ------------------------------------ | -------------------------------------------------------------------------------------------- | -------------------------------------- |
| `global.imageRegistry`               | Global Docker image registry                                                                 | `nil`                                  |
| `image.registry`                     | NATS Streaming image registry                                                                | `docker.io`                            |
| `image.repository`                   | NATS Streaming Image name                                                                    | `nats-streaming`                       |
| `image.tag`                          | NATS Streaming Image tag                                                                     | `{VERSION}`                            |
| `image.pullPolicy`                   | Image pull policy                                                                            | `IfNotPresent`                         |
| `image.pullSecrets`                  | Specify image pull secrets                                                                   | `nil`                                  |
| `auth.enabled`                       | Switch to enable/disable client authentication                                               | `true`                                 |
| `auth.user`                          | Client authentication user                                                                   | `nats_cluster`                         |
| `auth.password`                      | Client authentication password                                                               | `random alhpanumeric string (10)`      |
| `auth.token`                         | Client authentication token                                                                  | `nil`                                  |
| `auth.secretName`                    | Client authentication secret name                                                            | `nil`                                  |
| `auth.secretKey`                     | Client authentication secret key                                                             | `nil`                                  |
| `clusterID`                          | NATS Streaming Cluster Name ID                                                               | `"test-cluster"`                       |
| `natsSvc`                            | External NATS Server URL                                                                     | `"nats://username:password@nats:4222"` |
| `maxChannels`                        | Max # of channels                                                                            | `100`                                  |
| `maxSubs`                            | Max # of subscriptions per channel                                                           | `1000`                                 |
| `maxMsgs`                            | Max # of messages per channel                                                                | `"1000000"`                            |
| `maxBytes`                           | Max messages total size per channel                                                          | `900mb`                                |
| `maxAge`                             | Max duration a message can be stored                                                         | `"0s" (unlimited)`                     |
| `maxMsgs`                            | Max # of messages per channel                                                                | `1000000`                              |
| `debug`                              | Enable debugging                                                                             | `false`                                |
| `trace`                              | Enable detailed tracing                                                                      | `false`                                |
| `replicaCount`                       | Number of NATS Streaming nodes                                                               | `3`                                    |
| `securityContext.enabled`            | Enable security context                                                                      | `true`                                 |
| `securityContext.fsGroup`            | Group ID for the container                                                                   | `1001`                                 |
| `securityContext.runAsUser`          | User ID for the container                                                                    | `1001`                                 |
| `statefulset.updateStrategy`         | Statefulsets Update strategy                                                                 | `RollingUpdate`                        |
| `statefulset.rollingUpdatePartition` | Partition for Rolling Update strategy                                                        | `nil`                                  |
| `podLabels`                          | Additional labels to be added to pods                                                        | {}                                     |
| `podAnnotations`                     | Annotations to be added to pods                                                              | {}                                     |
| `nodeSelector`                       | Node labels for pod assignment                                                               | `nil`                                  |
| `schedulerName`                      | Name of an alternate                                                                         | `nil`                                  |
| `antiAffinity`                       | Anti-affinity for pod assignment                                                             | `soft`                                 |
| `tolerations`                        | Toleration labels for pod assignment                                                         | `nil`                                  |
| `resources`                          | CPU/Memory resource requests/limits                                                          | {}                                     |
| `livenessProbe.initialDelaySeconds`  | Delay before liveness probe is initiated                                                     | `30`                                   |
| `livenessProbe.periodSeconds`        | How often to perform the probe                                                               | `10`                                   |
| `livenessProbe.timeoutSeconds`       | When the probe times out                                                                     | `5`                                    |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the probe to be considered successful after having failed. | `1`                                    |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the probe to be considered failed after having succeeded.   | `6`                                    |
| `readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated                                                    | `5`                                    |
| `readinessProbe.periodSeconds`       | How often to perform the probe                                                               | `10`                                   |
| `readinessProbe.timeoutSeconds`      | When the probe times out                                                                     | `5`                                    |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the probe to be considered failed after having succeeded.   | `6`                                    |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the probe to be considered successful after having failed. | `1`                                    |
| `monitoring.service.type`            | Kubernetes Service type (NATS Streaming monitoring)                                          | `ClusterIP`                            |
| `monitoring.service.port`            | NATS Streaming monitoring port                                                               | `8222`                                 |
| `monitoring.service.nodePort`        | Port to bind to for NodePort service type (NATS Streaming monitoring)                        | `nil`                                  |
| `monitoring.service.annotations`     | Annotations for NATS Streaming monitoring service                                            | {}                                     |
| `monitoring.service.loadBalancerIP`  | loadBalancerIP if NATS Streaming monitoring service type is `LoadBalancer`                   | `nil`                                  |
| `networkPolicy.enabled`              | Enable NetworkPolicy                                                                         | `false`                                |
| `sidecars`                           | Attach additional containers to the pod.                                                     | `nil`                                  |

### File Specific Persistence Configuration

| Parameter                         | Description                        | Default          |
| --------------------------------- | ---------------------------------- | ---------------- |
| `persistence.file.compactEnabled` | Enable compaction                  | true             |
| `persistence.file.bufferSize`     | File buffer size (in bytes)        | "2097152"  (2MB) |
| `persistence.file.crc`            | Enable file CRC-32 checksum        | true             |
| `persistence.file.sync`           | Enable File.Sync on Flush          | true             |
| `persistence.file.fdsLimit`       | Max File Descriptor limit (approx) | 0 (unlimited)    |

*Additional configuration parameters not typically used may be found in [values.yaml](values.yaml).*
