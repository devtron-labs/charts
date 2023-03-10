{{/* Returns Postgres db service name */}}

{{- define "postgres.host" }}
{{- if $.Values.global.externalDatabase }}
{{- print "clair-postgresql.devtroncd" }}
{{- else }}
{{- print "postgresql-postgresql.devtroncd" }}
{{- end }}
{{- end }}