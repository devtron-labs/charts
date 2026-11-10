{{- define "aws-load-balancer-controller.selectorLabels" -}}

{{- if .Values.customSelectorLabels }}
{{- toYaml .Values.customSelectorLabels }}
{{- else }}
app.kubernetes.io/name: {{ include "aws-load-balancer-controller.name" .}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end -}}
