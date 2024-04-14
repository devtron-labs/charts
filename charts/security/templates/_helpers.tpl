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