## Introduction

Helm chart to run `migration using migrate/migrate` for a target cluster , which is added on devtron UI.

This helm chart create a k8s job which connect with database and run sql query from git repo for target cluster in particular database.


### Install with Helm

Run the following command to install the latest version of incluster migration integration:

```bash
helm repo add devtron https://helm.devtron.ai 

helm install my-db-migration devtron/migrant \
--set database_credentials.db_host=db-service --set database_credentials.db_port="1433"  --set database_credentials.db_password=db-secret-pass --set database_credentials.db_type="mysql" --set database_credentials.db_user=admin 
```

Here put database_credentials and the git repo url for `git cloning` 
For diffrent source code management tool eg. bitbucket, gitlab

we need to add url based on them, as we only run `git clone <repo-url>` command, thus put the url accordingly.

