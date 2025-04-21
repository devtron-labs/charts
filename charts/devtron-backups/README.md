# Devtron Backup Chart

This chart contains configuration files for setting up backup for Devtron stack using different cloud storage providers and persistence options.

## Introduction

Devtron Backup chart provides backup configurations for PostgreSQL databases and ArgoCD applications running in the Devtron environment. It supports backup to various cloud storage providers such as Azure Blob Storage, Google Cloud Storage (GCS), S3, as well as backup to persistent volume claims (PVC).

## Configuration

The backup configurations are defined in the YAML file, which specifies settings such as schedule, storage options, and encryption.

# Global Settings
| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.scheduleCron` | Cron schedule for backups | "0 */12 * * *" (twice daily) |
| `global.timezone` | Timezone for the cron schedule | UTC |
| `global.tolerations` | Pod tolerations for backup jobs | [] |
| `global.nodeSelector` | Node selection constraints | {} |
| `global.argocdversion` | ArgoCD version | v2 |
| `extraConfig` | Pass any additional custom fields under jobTemplate.spec in the Kubernetes CronJob spec. | {} |

### Azure Backup

Azure backup can be enabled by setting `AZURE.enabled` to `true` in the YAML file. Configure Azure storage account details and encryption settings as required.

## Azure Blob Storage Configuration

| Parameter | Description | Required |
|-----------|-------------|----------|
| `global.AZURE.enabled` | Enable Azure Blob Storage backup | Yes (set to `true`) |
| `AZURE_BLOB_ACCOUNT_NAME` | Azure storage account name | Yes |
| `AZURE_ACCOUNT_KEY` | Azure storage account key | Yes |
| `AZURE_BLOB_CONTAINER_FOR_POSTGRES` | Container name for PostgreSQL backups | Yes |
| `AZURE_BLOB_CONTAINER_FOR_ARGOCD` | Container name for ArgoCD backups | Yes |
| `encryption.enabled` | Enable backup encryption | No (defaults to `false`) |
| `encryption.passphrase` | Passphrase for encryption/decryption | Yes (if encryption enabled) |

### GCP Backup

GCP backup can be enabled by setting `GCP.enabled` to `true` in the YAML file. Configure the GCS bucket name, and optionally, provide GCP credentials if the default service account lacks permissions.

Parameter | Description | Required
|-----------|-------------|----------|
|`global.GCP.enabled` | Enable GCP storage backup | Yes (set to true) |
|`GCS_BUCKET_NAME` | GCS bucket name to store backups | Yes |
|`CREDENTIALS.enabled` | Use custom GCP credentials | No (defaults to false) |
|`GCP_CREDENTIALS_JSON` | Base64 encoded GCP service account credentials JSON | Yes (if CREDENTIALS.enabled: true) |
|`encryption.enabled` | Enable backup encryption | No (defaults to false) |
|`encryption.passphrase` | Passphrase for encryption/decryption | Yes (if encryption is enabled) |

### S3 Backup

S3 backup can be enabled by setting `S3.enabled` to `true` in the YAML file. Configure the S3 bucket details and encryption settings as required. 

## S3 Storage Configuration

| Parameter | Description | Required |
|-----------|-------------|----------|
| `global.S3.enabled` | Enable S3 storage backup | Yes (set to `true`) |
| `S3_BUCKET_NAME` | S3 bucket name | Yes |
| `S3_ACCESS_KEY` | S3 access key | Yes (unless `NODE_ROLE: true`) |
| `S3_SECRET_KEY` | S3 secret key | Yes (unless `NODE_ROLE: true`) |
| `AWS_REGION` | AWS region | Yes (for AWS S3) |
| `S3_ENDPOINT` | Custom endpoint for non-AWS S3 services | Yes (for non-AWS services) |
| `CA_BUNDLE` | Custom CA bundle for S3 service | No |
| `NODE_ROLE` | Use node's IAM role for S3 access | No (defaults to `true`) |
| `encryption.enabled` | Enable backup encryption | No (defaults to `false`) |
| `encryption.passphrase` | Passphrase for encryption/decryption | Yes (if encryption enabled) |

### PVC Backup

PVC backup can be enabled by setting `PERSISTENCE.enabled` to `true` in the YAML file. Specify PVC settings, including storage class and size.

|Parameter | Description | Required |
|-----------|-------------|----------|
|`global.PERSISTENCE.enabled` | Enable PVC backup | Yes (set to true)|
|`existingClaim` | Use an existing PVC claim | No (required if size is not set)|
| `size` | Size of the PVC to be created | Yes (if existingClaim is not provided)|
|`storageClass` | Storage class for the PVC | Yes (if existingClaim is not provided)|
|`encryption.enabled` | Enable backup encryption | No (defaults to false)|
|`encryption.passphrase`| Passphrase for encryption/decryption | Yes (if encryption is enabled)|

Additionally, remember to enable `postgress_backup` or `argocd_backup` according to your requirements in the YAML file.
If `GitOps` is enabled, ensure that `argocd_backup` is enabled."

## Usage

Follow the steps below to use the backup chart:

1. Modify the YAML file according to your backup requirements.
2. Apply the configurations to your Kubernetes cluster.

### Things to be considered while migrating from v0.1.x to v0.2.x:

Previously, in v0.1.x, support was available only for the following storage options:
- AWS S3
- Azure
- GCP
- PVC

In the updated version (v0.2.x), support for all types of storage options using the S3 protocol has been added, for example, AWS S3, MINIO, etc.
As we have merged the options for AWS and generic S3 into one, we have to consider a few key changes:
- `AWS` changed to `S3`
    - Previously, the configurations for AWS used to be set inside the `AWS:` option. Now it has changed to `S3:`, but only the naming has changed, not the functionality. 
- `AWS_ACCESS_KEY` changed to `S3_ACCESS_KEY`
    - This will continue to accept the ACCESS_KEY of the S3 storage, whether it be AWS S3 or any other storage options supporting the S3 protocol.
- `AWS_SECRET_KEY` changed to `S3_SECRET_KEY`
    - This will continue to accept the SECRET_KEY of the S3 storage, whether it be AWS S3 or any other storage options supporting the S3 protocol.
- `S3_ENDPOINT`
    - This option can be newly seen in the **v0.2.x**, which accepts the endpoint of the S3 storage service, for example, MINIO (Can be kept empty in the case of AWS S3 Bucket).
