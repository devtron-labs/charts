{{/*
Returns external database hostname
*/}}
{{- define "pg.host" }}
{{- if .Values.global.externalDatabase }}
{{- $secretData := .Values.global.externalDatabase.PG_PASSWORD }}
{{- $Secret := $secretData | b64enc }}
{{- $Secret }}
{{- else }}
{{- $secretObj := (lookup "v1" "Secret" "devtroncd" "postgresql-postgresql") | default dict }}
{{- $secretData := (get $secretObj "data") | default dict }}
{{- $Secret := (get $secretData "postgresql-password") | default (randAlphaNum 32) | b64enc }}
{{- $Secret }}
{{- end }}
{{- end }}