{{/*
Return full image
{{ include "common.image" ( dict "component" .Values.path.to.the.component "global" .Values.global .extraImage .extraImageTag .extraImageDigest ) }}
*/}}
{{- define "common.image" -}}
{{- $registryName := .component.registry | default .global.containerRegistry -}}
{{- $imageName := .extraImage | default .component.image -}}
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