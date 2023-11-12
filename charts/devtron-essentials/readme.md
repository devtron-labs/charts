# Need of this Chart 
While onboarding Devtron there are some essentials and required charts which are need to deployed on the cluster to use Devtron efficiently. So you can deployed this chart in one go. It will remove the extra efforts of deploying multiple charts. You just have to enable and disable the required chart which you want to deploy.

## Here are the list of charts Devtron essentials chart contain:-

 1. ### argo-rollouts controller
    Argo Rollouts is a Kubernetes controller and set of CRDs which provide advanced deployment capabilities such as blue-green, canary, canary analysis, experimentation, and progressive delivery features to Kubernetes.
 2. ### keda
    KEDA is a Kubernetes-based Event Driven Autoscaler. With KEDA, you can drive the scaling of any container in Kubernetes based on the number of events needing to be processed.

 3. ### metrics-server
    Metrics Server is a scalable, efficient source of container resource metrics for Kubernetes built-in autoscaling pipelines. It will help you monitor your application

 4. ### ESO operator
     External Secrets Operator is a Kubernetes operator that integrates external secret management systems like AWS Secrets Manager, HashiCorp Vault etc.

 5. ### aws load balancer ingress controller
      The AWS Load Balancer Controller manages AWS Elastic Load Balancers for a Kubernetes cluster.The controller provisions the following resources:
       * Application Load Balancer
       * Network Load Balancer 
    

 6. ### CSI driver
    The Amazon Elastic Block Store (Amazon EBS) Container Storage Interface (CSI) driver allows Amazon Elastic Kubernetes Service (Amazon EKS) clusters to manage the lifecycle of Amazon EBS volumes for persistent volumes.

 7. ### flagger controller
    Flagger is a progressive delivery tool that converts the release process for applications using Kubernetes to automatic operation.
 8. ### kyverno   
    Kyverno is a Policy Engine for Kubernetes.
    Kyverno policies can validate, mutate, generate, and cleanup Kubernetes resources, and verify image signatures and artifacts to help secure the software supply chain

 9. ### clair
    Clair is an open source project which provides a tool to monitor the security of your containers through the static analysis of vulnerabilities in appc and docker containers

 10. ### postgres
      PostgreSQL, also known as Postgres, is a free and open-source relational database management system emphasizing extensibility and SQL compliance
     
 11. ### cluster autoscaler
     For autoscaling of nodes as per your workloads you can use this chart to manage your cluster. Cluster autoscaler helps to manage nodes.
 12. ### nginx ingress
       The Ingress Controller is an application that runs in a cluster and configures an HTTP load balancer according to Ingress resources
     
 13. ### argo workflow
     Argo Workflows is an open source container-native workflow engine for orchestrating parallel jobs on Kubernetes
 14. ### winter-solider
     Winter Soilder is an open-source tool created by Devtron.
 1.Delete k8s resource based on conditions.
 2.Scale down the Workload to Zero at a Specific period of date & time.

### Note :
If You enable in-cluster cd chart make sure you should create two namespace mention in values.yaml.





