# scoop_test
## Configuration

The following table lists the configurable parameters of the cert-manager chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `scoop.imagePullSecrets` | Reference to one or more secrets to be used when pulling images |`scoop-imagepull-secret` |
| `scoop.existingImagePullSecret` | Already existing image pull secret, if not present can create one |`devtron-image-pull`
| `image.repository` | Image repository | `devtroninc.azurecr.io/scoop:f6a34987-629-23113` |
| `image.tag` | Image tag | `` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `replicaCount`  | Number of scoop replicas  | `1` |
| `ScoopNamespace` | NameSpace where all resources will get created | ``
| `ConfigMap.enabled` | If `true`, create and use configMap to pass in ConfigmapRefSecret | `false` |
| `ConfigMap.name` | Override the namespace used to store | `scoop-configmap-secret` | 
| `secrets.enabled` |  If `true`, create and use secret.yaml to pass in SecretRef | `false` | 
| `secrets.name` | Override the namespace used to store | `scoop-secret` |