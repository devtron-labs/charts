{{- define "devtron.postgresBackup" -}}
  {{- if .Values.global.S3.CA_BUNDLE }}
    {{- if .Values.global.S3.S3_ENDPOINT }}
      {{- if .Values.global.S3.encryption.enabled }} 
        set -ex; date1=$(date +%Y%m%d-%H%M); path=$(pwd);  echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /postgres/backup.tar; rm -rvf /postgres/backup.tar; mv /postgres/backup.tar.gpg /postgres/backup-$date1.tar.gpg; aws s3 cp /postgres/backup-$date1.tar.gpg s3://$S3_BUCKET/postgres/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }} --ca-bundle $AWS_CA_BUNDLE;   
      {{- else }}
        set -ex; date1=$(date +%Y%m%d-%H%M); path=$(pwd);  echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; mv /postgres/backup.tar /postgres/backup-$date1.tar; aws s3 cp /postgres/backup-$date1.tar s3://$S3_BUCKET/postgres/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }} --ca-bundle $AWS_CA_BUNDLE;
      {{- end }}
    {{- else}}
      {{- if .Values.global.S3.encryption.enabled }} 
        set -ex; date1=$(date +%Y%m%d-%H%M); path=$(pwd);  echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /postgres/backup.tar; rm -rvf /postgres/backup.tar; mv /postgres/backup.tar.gpg /postgres/backup-$date1.tar.gpg; aws s3 cp /postgres/backup-$date1.tar.gpg s3://$S3_BUCKET/postgres/ ;
      {{- else}}
        set -ex; date1=$(date +%Y%m%d-%H%M); path=$(pwd);  echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; mv /postgres/backup.tar /postgres/backup-$date1.tar; aws s3 cp /postgres/backup-$date1.tar s3://$S3_BUCKET/postgres/;
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
    {{- if .Values.global.S3.CA_BUNDLE }}
        {{- if .Values.global.S3.S3_ENDPOINT }}
            {{- if .Values.global.S3.encryption.enabled }} 
              set -ex; date1=$(date +%Y%m%d-%H%M);  echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /argocd/backup.yaml; rm -rvf /argocd/backup.yaml; mv /argocd/backup.yaml.gpg /argocd/backup-$date1.yaml.gpg; aws s3 cp /argocd/backup-$date1.yaml.gpg s3://$S3_BUCKET/argocd/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }};
            {{- else }}
              set -ex; date1=$(date +%Y%m%d-%H%M);  echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; mv /argocd/backup.yaml /argocd/backup-$date1.yaml; aws s3 cp /argocd/backup-$date1.yaml s3://$S3_BUCKET/argocd/ --endpoint-url {{ .Values.global.S3.S3_ENDPOINT }};
            {{- end }}
        {{- else}}
            {{- if .Values.global.S3.encryption.enabled }} 
              set -ex; date1=$(date +%Y%m%d-%H%M);  echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; gpg -c --batch --passphrase {{ .Values.global.S3.encryption.passphrase }} /argocd/backup.yaml; rm -rvf /argocd/backup.yaml; mv /argocd/backup.yaml.gpg /argocd/backup-$date1.yaml.gpg; aws s3 cp /argocd/backup-$date1.yaml.gpg s3://$S3_BUCKET/argocd/;
            {{- else}}
              set -ex; date1=$(date +%Y%m%d-%H%M);  echo "$CA_BUNDLE" > /cabundle.pem; export AWS_CA_BUNDLE=/cabundle.pem; mv /argocd/backup.yaml /argocd/backup-$date1.yaml; aws s3 cp /argocd/backup-$date1.yaml s3://$S3_BUCKET/argocd/;
            {{- end }}
        {{- end }}
    {{- else }}
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
{{- end }}

{{/*
Streaming S3 backup. The CronJob supplies database, S3, and Secret-backed
configuration through environment variables. This helper is used only by
PostgreSQL streaming mode.
*/}}
{{- define "devtron.postgresStreamingBackup" -}}
set +x
set -euo pipefail

: "${PGHOST:?PGHOST is required}"
: "${PGPORT:?PGPORT is required}"
: "${PGUSER:?PGUSER is required}"
: "${PGPASSWORD:?PGPASSWORD is required}"
: "${S3_BUCKET:?S3_BUCKET is required}"
: "${AWS_DEFAULT_REGION:?AWS_DEFAULT_REGION is required}"
: "${EXPECTED_STREAM_BYTES:?EXPECTED_STREAM_BYTES is required}"
if [[ ! "$EXPECTED_STREAM_BYTES" =~ ^[1-9][0-9]*$ ]]; then
  echo "EXPECTED_STREAM_BYTES must be a positive integer." >&2
  exit 1
fi
{{- if .Values.global.S3.encryption.enabled }}
: "${BACKUP_PASSPHRASE:?BACKUP_PASSPHRASE is required when encryption is enabled}"
{{- end }}

work_dir="$(mktemp -d)"
trap 'rm -rf -- "$work_dir"' EXIT

# Options for the S3 upload.
s3_args=(--expected-size "$EXPECTED_STREAM_BYTES")
if [[ -n "${S3_ENDPOINT:-}" ]]; then
  s3_args+=(--endpoint-url "$S3_ENDPOINT")
fi
if [[ -n "${CA_BUNDLE:-}" ]]; then
  printf '%s\n' "$CA_BUNDLE" > "$work_dir/ca-bundle.pem"
  s3_args+=(--ca-bundle "$work_dir/ca-bundle.pem")
fi

backup_id="$(date +%Y%m%d-%H%M)"
backup_uri="s3://${S3_BUCKET}/postgres/backup-${backup_id}.tar"
{{- if .Values.global.S3.encryption.enabled }}
backup_uri="${backup_uri}.gpg"
mkdir -m 700 "$work_dir/gnupg"
{{- end }}

dump_database() {
  pg_dumpall \
    --host="$PGHOST" \
    --port="$PGPORT" \
    --username="$PGUSER" \
    --no-password \
    --exclude-database=clairv4 \
    --no-privileges
}

echo "Starting PostgreSQL streaming backup."
echo "Destination: $backup_uri"

# S3 shows the file only when aws reaches the end of its input.
# Start aws first, reading from a named pipe, so the end of input
# can be held back until the dump result is known.
stream="$work_dir/stream"
mkfifo "$stream"
aws s3 cp - "$backup_uri" "${s3_args[@]}" < "$stream" &
upload_pid=$!
exec 4> "$stream"

{{- if .Values.global.S3.encryption.enabled }}
if dump_database \
  | gpg --homedir "$work_dir/gnupg" \
      --batch \
      --yes \
      --pinentry-mode loopback \
      --passphrase-fd 3 \
      --symmetric \
      --output - \
      3<<< "$BACKUP_PASSPHRASE" \
  >&4
{{- else }}
if dump_database >&4
{{- end }}
then
  # Dump succeeded: close the pipe so aws finishes the upload.
  exec 4>&-
  if ! wait "$upload_pid"; then
    echo "Upload to S3 failed." >&2
    exit 1
  fi
  echo "Backup pipeline succeeded."
  echo "Backup: $backup_uri"
else
  # Dump failed: stop aws before it reaches the end of its input,
  # so the upload is never completed and no file appears in S3.
  kill "$upload_pid" 2>/dev/null || true
  wait "$upload_pid" 2>/dev/null || true
  echo "Backup pipeline failed; nothing was uploaded." >&2
  exit 1
fi
{{- end }}
