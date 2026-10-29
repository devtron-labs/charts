## Kubernetes Security Policies

This document describes the configuration options for various Kubernetes security policies implemented through a ```values.yaml``` file. These policies help enforce security best practices and resource constraints in your Kubernetes cluster.

The following sections describe the policies that are defined in the values.yaml file.

## Table of Contents

1. Exclude Label
2. PVC Creation Policy
3. Namespace Deletion Policy
4. Load Balancer Creation Policy
5. Application Deletion Policy
6. Resource Policies
    - Without Resource Policy
    - Limit Resource Policy
7. Admin Cluster Role Creation
8. ClusterRole Binding Creation
9. Readiness and Liveness Policy
10. Pod Security Policy
11. Container Security Policy
12. Extra Validating Policy

## Exclude Label

The ```excludeLabel``` Resources will be excluded from the scope of the policy if these labels are present.

## PVC Creation Policy

The ```pvcCreationPolicy``` restricts the creation of Persistent Volume Claims (PVCs). When enabled, this policy prevents the creation of PVCs in specified namespaces.

## Namespace Deletion Policy

The ```namespaceDeletionPolicy``` restricts the deletion of namespaces. It applies only to the namespaces listed in the configuration.

## Load Balancer Creation Policy

The ```loadBalancerCreationPolicy``` prevents the creation of LoadBalancer type services in specified namespaces.

## Application Deletion Policy

The ```appDeletionPolicy``` prevents the deletion of applications within specified namespaces.

## Resource Policies
   ## Without Resource Policy
The ```WithoutResource policy``` enforces the specification of resource requests and limits for deployments, statefulsets, and other resources. If this policy is enabled, it denies the creation or update of resources that do not specify resource requests or limits.
   ## Limit Resource Policy
The ```limitResourcePolicy``` enforces a maximum CPU and memory limit for the specified resources (pods, deployments, statefulsets, etc.). If the resources do not meet the specified limits, the operation is denied.

## Admin Cluster Role Creation

   The ```adminClusterRoleCreationpolicy``` prevents the creation of new roles or cluster roles with admin-level permissions.

## ClusterRole Binding Creation
   
   The ```clusterRoleBindingCreationpolicy``` restricts the creation of clusterRoleBindings with cluster-admin access.

## Readiness and Liveness Policy
   
   The ```readinessAndLivenessPolicy``` ensures that all deployments, statefulsets, or rollouts define readiness and liveness probes for their containers. These probes ensure that pods are considered healthy only when they pass the defined checks.

## Pod Security Policy

   The ```podSecurityPolicy``` defines security best practices for Kubernetes Pods. It prevents containers from running as root, ensures that the root file system is not writable, and disables privileged containers.

## Container Security Policy
   
   The ```containerSecurityPolicy``` defines additional security policies that apply to containers within pods. It ensures that containers adhere to security best practices, including non-root execution and restrictions on filesystem access and privilege escalation.

## Extra Validating Policy
   
   The ```extraValidatingPolicy``` section allows you to define additional custom validation policies beyond the default set. These policies can be used to enforce specific rules for your Kubernetes resources.