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

{{/*
Create a default fully qualified postgresql name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "postgresql.fullname" -}}
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "fullImage" }}
{{- $registryName := .currentPosition.registry | default .global.containerRegistry -}}
{{- $imageName := .image | default .currentPosition.image   -}}
{{- $imageTag := .tag | default .currentPosition.tag   -}}
{{- $imageDigest := .digest | default .currentPosition.digest -}}
{{- if and  $registryName $imageName $imageTag $imageDigest }}
    {{- printf "%s/%s:%s@%s" $registryName $imageName $imageTag $imageDigest -}}
{{- else  if and  $registryName $imageName $imageTag  -}}    
    {{- printf "%s/%s:%s" $registryName $imageName $imageTag  -}}
{{- else if and  $registryName $imageName $imageDigest }}
    {{- printf "%s/%s@%s" $registryName $imageName $imageDigest -}}
{{- else  }}
    {{- printf "%s/%s" $registryName $imageName  -}}
{{- end }}
{{- end -}}
