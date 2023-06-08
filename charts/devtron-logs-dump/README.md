# Devtron Logs Dump Chart

This Helm chart is used to dump the logs of various microservices in the Devtron stack to the Devtron S3 bucket.

## Microservices Logs

The chart is configured to dump the logs of the following microservices:

Dashboard
Devtron
Kubewatch
Kubelink
Argo Rollouts
ArgoCD Dex Server
Devtron NATS
Git Sensor
Lens

## Installation

To install the Devtron Logs chart, follow the steps below:

Make sure you have Helm installed and configured.
Clone the Devtron Logs repository.
Navigate to the directory containing the chart.
Run the following Helm command to install the chart:

**helm install devtron-logs -n devtroncd -f <chart-location>**

Make sure to replace <chart-location> with the location of your chart values file.

Note: You can customize the chart by modifying the values in the chart values file before installation.