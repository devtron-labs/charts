# https://github.com/argoproj/argo-helm/blob/argo-cd-5.13.9/charts/argo-cd/templates/_common.tpl#L57
{{- define "argo-cd.selectorLabels" -}}
{{- if .context.Values.customSelectorLabels }}
{{- if .name -}}
app.kubernetes.io/name: {{ include "argo-cd.name" .context }}-{{ .name }}
{{ end -}}
{{- toYaml .context.Values.customSelectorLabels }}
{{- else }}
{{- if .name -}}
app.kubernetes.io/name: {{ include "argo-cd.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}
{{- end }}

# https://github.com/argoproj/argo-helm/blob/argo-rollouts-2.39.0/charts/argo-rollouts/templates/_helpers.tpl#L64
{{- define "argo-rollouts.selectorLabels" -}}
{{- if  .Values.customSelectorLabels -}}
{{- toYaml .Values.customSelectorLabels }}
{{- else -}}
app.kubernetes.io/name: {{ include "argo-rollouts.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}


# https://github.com/groundhog2k/helm-charts/blob/master/charts/postgres/templates/_helpers.tpl#L48
{{- define "postgres.selectorLabels" -}}
{{- if  .Values.customSelectorLabels -}}
{{- toYaml .Values.customSelectorLabels }}
{{- else -}}
app.kubernetes.io/name: {{ include "postgres.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}
