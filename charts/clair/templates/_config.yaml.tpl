introspection_addr: {{ .Values.config.introspection_addr }}
http_listen_addr: {{ .Values.config.http_listen_addr }}
log_level: {{ .Values.config.log_level }}
indexer:
  {{- if .Values.config.postgresPassword }}
  connstring: "host={{ .Values.config.postgresHost }} port={{ .Values.config.postgresPort }} dbname={{ .Values.config.postgresdbname }} user={{ .Values.config.postgresUser }} password={{ .Values.config.postgresPassword }} sslmode=disable"
  {{- else }}
  connstring: "host={{ .Values.config.postgresHost }} port={{ .Values.config.postgresPort }} dbname={{ .Values.config.postgresdbname }} user={{ .Values.config.postgresUser }} sslmode=disable"
  {{- end }}
  scanlock_retry: {{ .Values.config.indexer.scanlock_retry }}
  layer_scan_concurrency: {{ .Values.config.indexer.layer_scan_concurrency }}
  migrations: {{ .Values.config.indexer.migrations }}
  {{- if .Values.config.indexer.extraConfig }}
  {{- toYaml .Values.config.indexer.extraConfig | nindent 2 }}
  {{- end }}
matcher:
  indexer_addr: "{{ .Values.config.matcher.indexer_addr }}"
  {{- if .Values.config.postgresPassword }}
  connstring: "host={{ .Values.config.postgresHost }} port={{ .Values.config.postgresPort }} dbname={{ .Values.config.postgresdbname }} user={{ .Values.config.postgresUser }} password={{ .Values.config.postgresPassword }} sslmode=disable"
  {{- else }}
  connstring: "host={{ .Values.config.postgresHost }} port={{ .Values.config.postgresPort }} dbname={{ .Values.config.postgresdbname }} user={{ .Values.config.postgresUser }} sslmode=disable"
  {{- end }}
  max_conn_pool: {{ .Values.config.matcher.max_conn_pool }}
  run: ""
  migrations: {{ .Values.config.matcher.migrations }}
  updater_sets:
  {{- range $key, $value := .Values.config.matcher.clairUpdaterSets }}
  - "{{ $value }}"
  {{- end }}
  {{- if .Values.config.matcher.extraConfig }}
  {{- toYaml .Values.config.matcher.extraConfig | nindent 2 }}
  {{- end }}
notifier:
  {{- if .Values.config.postgresPassword }}
  connstring: "host={{ .Values.config.postgresHost }} port={{ .Values.config.postgresPort }} dbname={{ .Values.config.postgresdbname }} user={{ .Values.config.postgresUser }} password={{ .Values.config.postgresPassword }} sslmode=disable"
  {{- else }}
  connstring: "host={{ .Values.config.postgresHost }} port={{ .Values.config.postgresPort }} dbname={{ .Values.config.postgresdbname }} user={{ .Values.config.postgresUser }} sslmode=disable"
  {{- end }}
  delivery_interval: {{ .Values.config.notifier.delivery_interval }}
  poll_interval: {{ .Values.config.notifier.poll_interval }}
  migrations: {{ .Values.config.notifier.migrations }}
  {{- if .Values.config.notifier.extraConfig }}
  {{- toYaml .Values.config.notifier.extraConfig | nindent 2 }}
  {{- end }}