introspection_addr: {{ .Values.config.introspection_addr }}
http_listen_addr: {{ .Values.config.http_listen_addr }}
log_level: {{ .Values.config.log_level }}
indexer:
  connstring: "host={{ .Values.config.clairHost }} port={{ .Values.config.clairPort }} dbname={{ .Values.config.dbname }} user={{ .Values.config.user }} password={{ .Values.config.password }} sslmode=disable"
  scanlock_retry: {{ .Values.config.scanlock_retry }}
  layer_scan_concurrency: {{ .Values.config.layer_scan_concurrency }}
  migrations: {{ .Values.config.migrations }}

matcher:
  indexer_addr: "{{ .Values.config.indexer_addr }}"
  connstring: "host={{ .Values.config.clairHost }} port={{ .Values.config.clairPort }} dbname={{ .Values.config.dbname }} user={{ .Values.config.user }} password={{ .Values.config.password }} sslmode=disable"
  max_conn_pool: {{ .Values.config.max_conn_pool }}
  run: ""
  migrations: {{ .Values.config.migrations }}
  updater_sets:
  {{- range $key, $value := .Values.config.clairUpdaterSets }}
  - "{{ $value }}"
  {{- end }}
    
notifier:
  connstring: "host={{ .Values.config.clairHost }} port={{ .Values.config.clairPort }} dbname={{ .Values.config.dbname }} user={{ .Values.config.user }} password={{ .Values.config.password }} sslmode=disable"
  delivery_interval: {{ .Values.config.delivery_interval }}
  poll_interval: {{ .Values.config.poll_interval }}
  migrations: {{ .Values.config.migrations }}