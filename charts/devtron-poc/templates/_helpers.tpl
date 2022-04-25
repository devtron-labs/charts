{{- define "bom.values" -}}
  images:
      {{ range .Files.Lines "bom.toml" }}
        {{ . }}{{ end }}
{{- end -}}

{{- define "bcc.values" -}}
  images:
      {{- range $key, $val := .Files.Lines "bom.toml" }}
        {{- . | nindent 2 }} {{ end }}
{{- end -}}