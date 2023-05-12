## The indentation has to use a single space in order to generate a valid yaml file in actual usage.
{{- define "m1" -}}
limits:
 memory: "0.75G"
 cpu: "0.5"
requests:
 memory: "0.5G"
 cpu: "0.2"
{{- end }}

{{- define "m2" -}}
limits:
 memory: "1.5G"
 cpu: "0.5"
requests:
 memory: "1G"
 cpu: "0.2"
{{- end }}

{{- define "m3" -}}
limits:
 memory: "2.5G"
 cpu: "0.8"
requests:
 memory: "2G"
 cpu: "0.5"
{{- end }}

{{- define "c1" -}}
limits:
 memory: "0.75G"
 cpu: "0.7"
requests:
 memory: "0.5G"
 cpu: "0.5"
{{- end }}

{{- define "c2" -}}
limits:
 memory: "0.75G"
 cpu: "1.5"
requests:
 memory: "0.5G"
 cpu: "1"
{{- end }}

{{- define "c3" -}}
limits:
 memory: "1.25G"
 cpu: "2"
requests:
 memory: "1G"
 cpu: "1.5"
{{- end }}