# Google Anthos Service Mesh Virtual Service Helm Chart

Virtual Service help us to decide how and what traffic gets routed to the backend service.

## Usage

## Pre-requistes

* All required Google Anthos Service Mesh components should be installed on Google Kubernetes Engine. You can also use Google Anthos Service Mesh Deployment Helm Chart provided by Devtron labs.
* This Helm Chart deployment require a GKE cluster version 1.16 or later

## Following Istio Features are implemented in Helm Chart

* Intelligent routing and load balancing - Canary deployment/Weighted routing, HTTP Header based routing
* Network resilience - Retry, Timeout
* Policy enforcement - Peer TLS authentication

## Canary Deployment using Istio

If we want to send 10% traffic to the canary version then routing rule can be configured like below.

```yaml
## Create Istio Virtual Service for Weighted routing Policy
weightVirtualsvc:
  enabled: true
  name: app-vrtsvc
  hosts: example.com
  gateways: asm-ingress/asm-ingressgateway
  destination:
    v1:
      host: g-app-service
      port: 80
      subset: g-app-v1
      weight: 90
    v1:
      host: g-app-service
      port: 80
      subset: g-app-v2
      weight: 10

## DestinationRule defines policies that apply to traffic intended for a service after routing has occurred.
destinationrule:
  name: app-destrule
  host: g-app-service
  destination:
    v1:
      subset: g-app-v1
    v2:
      subset: g-app-v2
```

In order to weighted routing to work following need to be configured.

* Single kubernetes service is exposed for both version of kubernetes deployment.
* Here to route to the specific kubernetes deployment kubernetes label is used and currently we have configured a label to be ```"app: <subset-value>"```

## Retry and Timeout Policy using Istio

Retry policy specifies istio attempts to connect to a backend service if the initial call fails.
It is used to build resilency in Microservices architecture.

The following example configures a maximum of 4 retries to connect to this service subset after an initial call failure, each with a 2 second timeout for HTTP 5xx status code results and after completing 10 seconds will no longer try to conncet to the service.

```yaml
## Create Istio Virtual Service for HTTP Retry Policy
retryVirtualsvc:
  enabled: true
  name: retryroute01
  hosts: demo.com
  gateways: asm-ingress/asm-ingressgateway
  destination:
    host: g-app-service
    subset: g-app-v1
    retries:
      attempts: 4
      perTryTimeout: 2s
      retryOn: 5xx
      timeout: 10s

## DestinationRule defines policies that apply to traffic intended for a service after routing has occurred.
destinationrule:
  name: app-destrule
  host: g-app-service
  destination:
    v1:
      subset: g-app-v1
```

## Header based routing using Istio

### Regex based Match

Following example demonstrates the custom header Pin Value matching between range of 100 to 200 will goes to it's respective service.

```yaml
# Create Istio Virtual Service for Header Based Routing Policy
headerVirtualsvc:
  enabled: true
  name: headerroute01
  hosts: demo.com
  gateways: asm-ingress/asm-ingressgateway
  headerValue: Pin
  regex: 
    enabled: true
    value: (10[0-9]|1[1-9][0-9]|200)
  exact:
    enabled: false
  destination:
    host: g-app-service
    subset: g-app-v1

## DestinationRule defines policies that apply to traffic intended for a service after routing has occurred.
destinationrule:
  name: app-destrule
  host: g-app-service
  destination:
    v1:
      subset: g-app-v1
```

### Exact Header value Match

Match only requests where the URL contains a custom "server" header with value "webex".

```yaml
# Create Istio Virtual Service for Header Based Routing Policy
headerVirtualsvc:
  enabled: true
  name: headerroute01
  hosts: demo.com
  gateways: asm-ingress/asm-ingressgateway
  headerValue: server
  regex: 
    enabled: false
  exact:
    enabled: true
    value: webex
  destination:
    host: g-app-service
    subset: g-app-v1

## DestinationRule defines policies that apply to traffic intended for a service after routing has occurred.
destinationrule:
  name: app-destrule
  host: g-app-service
  destination:
    v1:
      subset: g-app-v1
```

## Peer authentication Policy using Istio

PeerAuthentication defines how traffic will be tunneled (or not) to the sidecar.

```yaml
PeerAuthentication:
  enabled: true
  name: "default"
  tlsmode: STRICT
```

Following Modes are available in Peer authentication

1. UNSET - Inherit from parent, if has one. Otherwise treated as PERMISSIVE.
2. DISABLE - Connection is not tunneled.
3. PERMISSIVE - Connection can be either plaintext or mTLS tunnel.
4. STRICT - Connection is an mTLS tunnel (TLS with client cert must be presented).

Note: Peer authentication is cluster wide configuration.