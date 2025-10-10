{{/*
Common helpers for the karpenter-custom-resources chart.
*/}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "karpenter-custom-resources.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the name of the chart.
*/}}
{{- define "karpenter-custom-resources.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "karpenter-custom-resources.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "karpenter-custom-resources.labels" -}}
helm.sh/chart: {{ include "karpenter-custom-resources.chart" . }}
{{ include "karpenter-custom-resources.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "karpenter-custom-resources.selectorLabels" -}}
app.kubernetes.io/name: {{ include "karpenter-custom-resources.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "karpenter-custom-resources.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "karpenter-custom-resources.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for EC2NodeClass.
*/}}
{{- define "karpenter-custom-resources.ec2NodeClassApiVersion" -}}
{{- print "karpenter.k8s.aws/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for NodePool.
*/}}
{{- define "karpenter-custom-resources.nodePoolApiVersion" -}}
{{- print "karpenter.sh/v1" -}}
{{- end -}}

{{/*
Helper to safely access nested values with a default.
Usage: {{ include "karpenter-custom-resources.utils.get" (dict "object" .Values.some.object "path" "deeply.nested.value" "default" "fallback") }}
*/}}
{{- define "karpenter-custom-resources.utils.get" -}}
{{- $object := .object -}}
{{- $path := .path -}}
{{- $default := .default -}}
{{- $segments := splitList "." $path -}}
{{- $val := $object -}}
{{- range $segment := $segments -}}
  {{- if and (kindIs "map" $val) (hasKey $val $segment) -}}
    {{- $val = index $val $segment -}}
  {{- else -}}
    {{- $val = $default -}}
    {{- break -}}
  {{- end -}}
{{- end -}}
{{- $val -}}
{{- end -}}

{{/*
Helper to generate a unique name for resources within loops, if needed.
Not strictly necessary if `ec2NodeClass.name` and `nodePool.name` are unique and valid.
This is more of a defensive measure or for sub-resources if any were to be created.
*/}}
{{- define "karpenter-custom-resources.resourceName" -}}
{{- printf "%s-%s" (include "karpenter-custom-resources.fullname" .) .name | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Helper to process template strings in nested YAML structures
*/}}
{{- define "karpenter-custom-resources.processTemplates" -}}
{{- $value := . -}}
{{- if kindIs "string" $value -}}
{{- tpl $value $ -}}
{{- else if kindIs "map" $value -}}
{{- range $k, $v := $value }}
{{ $k }}: {{ include "karpenter-custom-resources.processTemplates" $v }}
{{- end -}}
{{- else if kindIs "slice" $value -}}
{{- range $value }}
- {{ include "karpenter-custom-resources.processTemplates" . }}
{{- end -}}
{{- else -}}
{{- $value -}}
{{- end -}}
{{- end -}}
