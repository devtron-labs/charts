### Instructions

If you want to specify the host
$ helm install --name=mautic . --set ingress.hosts[0].host=mautic.example.com --set ingress.hosts[0].paths[0]=/  --namespace=mautic

If you want to specify the host with SSL, make sure the TLS secretName you are specifying is already there in the namespace
$ helm install --name=mautic . --set ingress.hosts[0].host=mautic.example.com --set ingress.hosts[0].paths[0]=/ --set ingress.tls[0].secretName=cert-secret --set ingress.tls[0].hosts[0]=mautic.example.com --namespace=mautic

Easiest way for the HELM config is to change the values.yaml file and use it like this
$ helm install --name=mautic . --values=values.yaml 

You can have multiple value.yaml (each file for each client) and you can use it by using the `--values` clause.



### Note:

- After the installing helm, please wait a while as it takes few mins for application to come online.
- Make sure when you are creating the first user, on the 3rd screen (install-step-3) select the Email handling to 'Queue', after that you can configure the Email Configurations.