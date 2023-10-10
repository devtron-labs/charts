{{/* Returns Postgres db service name */}}

{{- define "postgres.host" }}
{{- if $.Values.global.externalDatabase }}
{{- print "clair-postgresql.devtroncd" }}
{{- else }}
{{- print "postgresql-postgresql.devtroncd" }}
{{- end }}
{{- end }}

{{/* Returns Postgres db name */}}

{{- define "postgres.db" }}
{{- if $.Values.global.externalDatabase }}
{{- print "clairv4" }}
{{- else }}
{{- print "orchestrator" }}
{{- end }}
{{- end }}