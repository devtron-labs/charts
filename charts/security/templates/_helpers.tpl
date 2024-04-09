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
