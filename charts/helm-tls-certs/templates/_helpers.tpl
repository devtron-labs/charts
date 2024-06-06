{{/*
Generate a certificate pair
*/}}
{{- define "devtron.gen-certs" -}}
{{- $ca := genCA "devtron-ca" (int .Values.certDays) -}}
{{- $cn := .Values.commonName | default (printf "%s.%s" .Release.Name .Release.Namespace) -}}
{{- $cert := genSignedCert $cn nil nil (int .Values.certDays) $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
{{- end -}}
