{{- define "devtron.postgresBackupCABundle" -}}
  {{- if .Values.global.S3.CA_BUNDLE }}
    {{- if .Values.global.S3.S3_ENDPOINT }}
      {{- if .Values.global.S3.encryption.enabled }} 
        set -ex; date1=$(date +%Y%m%d-%H%M); path=$(pwd); CA_BUNDLE=$(echo "$CA_BUNDLE" | base64 -d); echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /postgres/backup.tar; rm -rvf /postgres/backup.tar; mv /postgres/backup.tar.gpg /postgres/backup-$date1.tar.gpg; aws s3 cp /postgres/backup-$date1.tar.gpg s3://$S3_BUCKET/postgres/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }} --ca-bundle $AWS_CA_BUNDLE;   
      {{- else }}
        set -ex; date1=$(date +%Y%m%d-%H%M); path=$(pwd); CA_BUNDLE=$(echo "$CA_BUNDLE" | base64 -d); echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; mv /postgres/backup.tar /postgres/backup-$date1.tar; aws s3 cp /postgres/backup-$date1.tar s3://$S3_BUCKET/postgres/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }} --ca-bundle $AWS_CA_BUNDLE;
      {{- end }}
    {{- else}}
      {{- if .Values.global.S3.encryption.enabled }} 
        set -ex; date1=$(date +%Y%m%d-%H%M); path=$(pwd); CA_BUNDLE=$(echo "$CA_BUNDLE" | base64 -d); echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /postgres/backup.tar; rm -rvf /postgres/backup.tar; mv /postgres/backup.tar.gpg /postgres/backup-$date1.tar.gpg; aws s3 cp /postgres/backup-$date1.tar.gpg s3://$S3_BUCKET/postgres/ ;
      {{- else}}
        set -ex; date1=$(date +%Y%m%d-%H%M); path=$(pwd); CA_BUNDLE=$(echo "$CA_BUNDLE" | base64 -d); echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; mv /postgres/backup.tar /postgres/backup-$date1.tar; aws s3 cp /postgres/backup-$date1.tar s3://$S3_BUCKET/postgres/;
      {{- end }}
    {{- end }}
  {{- else }}
    {{- if .Values.global.S3.S3_ENDPOINT }}
      {{- if .Values.global.S3.encryption.enabled }}
        set -ex; date1=$(date +%Y%m%d-%H%M); gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /postgres/backup.tar; rm -rvf /postgres/backup.tar; mv /postgres/backup.tar.gpg /postgres/backup-$date1.tar.gpg; aws s3 cp /postgres/backup-$date1.tar.gpg s3://$S3_BUCKET/postgres/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }};        
      {{- else}}
        set -ex; date1=$(date +%Y%m%d-%H%M); mv /postgres/backup.tar /postgres/backup-$date1.tar; aws s3 cp /postgres/backup-$date1.tar s3://$S3_BUCKET/postgres/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }};
      {{- end }}
    {{- else}}
      {{- if .Values.global.S3.encryption.enabled }}    
        set -ex; date1=$(date +%Y%m%d-%H%M); gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /postgres/backup.tar; rm -rvf /postgres/backup.tar; mv /postgres/backup.tar.gpg /postgres/backup-$date1.tar.gpg; aws s3 cp /postgres/backup-$date1.tar.gpg s3://$S3_BUCKET/postgres/;
      {{- else}}
        set -ex; date1=$(date +%Y%m%d-%H%M); mv /postgres/backup.tar /postgres/backup-$date1.tar; aws s3 cp /postgres/backup-$date1.tar s3://$S3_BUCKET/postgres/;
      {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}

{{- define "devtron.argocdBackup" -}}
    {{- if .Values.global.S3.S3_ENDPOINT }}
        {{- if .Values.global.S3.encryption.enabled }}
         set -ex; date1=$(date +%Y%m%d-%H%M); gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /argocd/backup.yaml; rm -rvf /argocd/backup.yaml; mv /argocd/backup.yaml.gpg /argocd/backup-$date1.yaml.gpg; aws s3 cp /argocd/backup-$date1.yaml.gpg s3://$S3_BUCKET/argocd/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }};
        {{- else }}
         set -ex; date1=$(date +%Y%m%d-%H%M); mv /argocd/backup.yaml /argocd/backup-$date1.yaml; aws s3 cp /argocd/backup-$date1.yaml s3://$S3_BUCKET/argocd/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }};
        {{- end }}
    {{- else}}
        {{- if .Values.global.S3.encryption.enabled }}
         set -ex; date1=$(date +%Y%m%d-%H%M); gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /argocd/backup.yaml; rm -rvf /argocd/backup.yaml; mv /argocd/backup.yaml.gpg /argocd/backup-$date1.yaml.gpg; aws s3 cp /argocd/backup-$date1.yaml.gpg s3://$S3_BUCKET/argocd/;
        {{- else}}
         set -ex; date1=$(date +%Y%m%d-%H%M); mv /argocd/backup.yaml /argocd/backup-$date1.yaml; aws s3 cp /argocd/backup-$date1.yaml s3://$S3_BUCKET/argocd/;
        {{- end }}
    {{- end }}
{{- end }}