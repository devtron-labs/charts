# renew-ecr-k8s-cred

A Helm chart for renewing AWS ECR credentials and updating them in a Kubernetes secret.

## Introduction

This Helm chart creates a CronJob in Kubernetes to periodically renew AWS Elastic Container Registry (ECR) credentials and update them in a Kubernetes secret. This is useful for ensuring that your ECR credentials are always up to date, especially in environments where long-running workloads need continuous access to private ECR repositories.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+
- An AWS account with permissions to assume the specified role and access ECR
- The AWS CLI installed in the container image

## Installation

### Add the Helm Repository

```sh
# AWS credentials configuration
aws:
  accessKey: "your-aws-access-key"          # AWS Access Key ID of IAM role for authentication
  secretKey: "your-aws-secret-key"          # AWS Secret Access Key of IAM role for authentication
  region: "your-aws-region"                 # AWS region where your resources are located
  roleArn: "your-aws-role-arn"              # ARN of the AWS role to assume for getting temporary credentials
  sessionName: "your-session-name"          # Session name for the assumed role

# Kubernetes configuration
kubernetes:
  namespace: "your-namespace"               # Namespace in which to create or update the Kubernetes secret
  secretName: "your-secret-name"            # Name of the Kubernetes secret to create or update with ECR credentials

# ECR (Elastic Container Registry) configuration
ecr:
  account: "your-aws-account"               # AWS account ID where your ECR is located
  region: "your-ecr-region"                 # AWS region of your ECR

# CronJob configuration
cronjob:
  schedule: "0 */12 * * *"                  # Cron schedule for the job to run (every 12 hours)

# ServiceAccount configuration
serviceAccount:
  create: true                              # Set to true to create a new ServiceAccount, false to use an existing one
  name: "renew-ecr-k8s-creds-sa"            # Name of the ServiceAccount to create or use
```
