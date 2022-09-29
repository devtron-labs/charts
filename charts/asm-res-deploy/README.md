# Google Anthos Service Mesh Deployment Helm Chart

The following Helm chart deploy one-time deployment components for Anthos Service Mesh

# Usage

## Pre-requistes

1. This Helm Chart deployment require a Google Kubernetes Engine cluster version 1.16 or later

2. If you want to Enable Anthos Service mesh on existing GKE cluster then review the [Install Anthos Service mesh](https://cloud.google.com/architecture/exposing-service-mesh-apps-through-gke-ingress#install-service-mesh). 

3. Make sure all namespaces is labelled with "istio-injection=enabled"
```sh
kubectl label namespace asm-ingress istio-injection=enabled
```

4. Create kubernetes secret with tls certificate used by Istio Gateway.
```sh
kubectl -n asm-ingress create secret tls edge2mesh-credential \
 --key=<domain_name>.key \
 --cert=<domain_name>.crt
```

5. Create Static IP Address in Google cloud for GKE Ingress
```sh
gcloud compute addresses create ingress-ip --global
```

6. Get the static ip address
```sh
export GCLB_IP=$(gcloud compute addresses describe ingress-ip --global --format "value(address)")
echo ${GCLB_IP}
```

7. Configure Firewall Rule for LB backend communication with Istio Gateway.
```sh
gcloud compute firewall-rules update <rule_name> --description "L7 firewall rule" --allow tcp:15021,tcp:30000-32767,tcp:443 --source-ranges 130.211.0.0/22,35.191.0.0/16 --target-tags <node_name> --project <project_name>
```

## Post Deployment Steps

* Map GKE Ingress IP address to all DNS for manage certificates validation. 
* You might need to restart all the application pods for existing deployments, to add istio sidecar container.