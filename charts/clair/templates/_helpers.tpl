{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "clair.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "clair.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "common.clair.image" -}}
{{- $registryName := .component.registry | default .global.containerRegistry -}}
{{- $imageName := .extraImage | default .component.repository -}}
{{- $imageTag := .extraImageTag | default .component.tag -}}
{{- $imageDigest := .extraImageDigest | default .component.digest -}}
{{- if $registryName }}
    {{- if and $imageTag $imageDigest }}
        {{- printf "%s/%s@%s" $registryName $imageName $imageDigest -}}
    {{- else if $imageTag }}
        {{- printf "%s/%s:%s" $registryName $imageName $imageTag -}}
    {{- else if $imageDigest }}
        {{- printf "%s/%s@%s" $registryName $imageName $imageDigest -}}
    {{- else }}
        {{- printf "%s/%s" $registryName $imageName -}}
    {{- end }}
{{- else -}}
    {{- if and $imageTag $imageDigest }}
        {{- printf "%s@%s" $imageName $imageDigest -}}
    {{- else if $imageTag }}
        {{- printf "%s:%s" $imageName $imageTag -}}
    {{- else if $imageDigest }}
        {{- printf "%s@%s" $imageName $imageDigest -}}
    {{- else }}
        {{- printf "%s" $imageName -}}
    {{- end }}
{{- end -}}
{{- end -}}


{{/*
Expand the node selectors, tolerations, and image pull secrets for a Kubernetes resource.
Usage:
{{ include "common.schedulerConfig" (dict "nodeSelector" .Values.path.to.nodeSelector "tolerations" .Values.path.to.tolerations "imagePullSecrets" .Values.path.to.imagePullSecrets "global" .Values.global ) }}
*/}}

{{- define "common.schedulerConfig" -}}
  {{- if .nodeSelector }}
nodeSelector:
{{ toYaml .nodeSelector | indent 2 }}
  {{- else if .global.nodeSelector }}
nodeSelector:
{{ toYaml .global.nodeSelector | indent 2 }}
  {{- end }}
  {{- if .tolerations }}
tolerations:
{{ toYaml .tolerations | indent 2 }}
  {{- else if .global.tolerations }}
tolerations:
{{ toYaml .global.tolerations | indent 2 }}
  {{- end }}
  {{- if .imagePullSecrets }}
imagePullSecrets:
{{ toYaml .imagePullSecrets | indent 2 }}
  {{- else if .global.imagePullSecrets }}
imagePullSecrets:
{{ toYaml .global.imagePullSecrets | indent 2 }}
  {{- end }}
{{- end }}

{{/*
Generate dbconnection String
*/}}
{{- define "clair.dbconnstring" -}}
  {{- $globalDbConfig := dict -}}
  {{- if .Values.global -}}
    {{- $globalDbConfig = .Values.global.dbConfig | default dict -}}
  {{- end -}}
  {{- $pgAddr := .Values.config.PG_ADDR | default $globalDbConfig.PG_ADDR | default "postgresql-postgresql.devtroncd" -}}
  {{- $pgPort := .Values.config.PG_PORT | default $globalDbConfig.PG_PORT | default "5432" -}}
  {{- $pgDatabase := .Values.config.PG_DATABASE | default $globalDbConfig.PG_DATABASE | default "clairv4" -}}
  {{- $pgUser := .Values.config.PG_USER | default $globalDbConfig.PG_USER | default "postgres" -}}
  {{- if .Values.config.postgresPassword }}
  connstring: "host={{ $pgAddr }} port={{ $pgPort }} dbname={{ $pgDatabase }} user={{ $pgUser }} password={{ .Values.config.postgresPassword }} sslmode=disable"
  {{- else }}
  connstring: "host={{ $pgAddr }} port={{ $pgPort }} dbname={{ $pgDatabase }} user={{ $pgUser }} sslmode=disable"
  {{- end }}
{{- end -}}

{{/*
Generate postgres host
*/}}
{{- define "clair.postgresHost" -}}
  {{- $globalDbConfig := dict -}}
  {{- if .Values.global -}}
    {{- $globalDbConfig = .Values.global.dbConfig | default dict -}}
  {{- end -}}
  {{- .Values.config.PG_ADDR | default $globalDbConfig.PG_ADDR | default "postgresql-postgresql.devtroncd" -}}
{{- end -}}

{{/*
Generate postgres port 
*/}}
{{- define "clair.postgresPort" -}}
  {{- $globalDbConfig := dict -}}
  {{- if .Values.global -}}
    {{- $globalDbConfig = .Values.global.dbConfig | default dict -}}
  {{- end -}}
  {{- .Values.config.PG_PORT | default $globalDbConfig.PG_PORT | default "5432" -}}
{{- end -}}