clair:
introspection_addr: {{ .Values.config.introspection_addr }}
http_listen_addr: {{ .Values.config.http_listen_addr }}
log_level: debug
  database:
    # Database driver.
    type: pgsql
    options:
      # PostgreSQL Connection string.
      # https://www.postgresql.org/docs/current/static/libpq-connect.html#LIBPQ-CONNSTRING
      {{- if .Values.config.postgresURI }}
      source: "{{ .Values.config.postgresURI }}"
      {{ else }}
      source: "host={{ template "postgresql.fullname" . }} port=5432 user={{ .Values.postgresql.postgresqlUsername }} password={{ .Values.postgresql.postgresqlPassword }} dbname={{ .Values.postgresql.postgresqlDatabase }} sslmode=disable statement_timeout=60000"
      {{ end }}

      # Number of elements kept in the cache.
      # Values unlikely to change (e.g. namespaces) are cached in order to save prevent needless roundtrips to the database.
      cachesize: 16384

      # 32-bit URL-safe base64 key used to encrypt pagination tokens.
      # If one is not provided, it will be generated.
      # Multiple clair instances in the same cluster need the same value.
      paginationkey: "{{ .Values.config.paginationKey }}"
  api:
    # v3 grpc/RESTful API server address.
    addr: "0.0.0.0:{{ .Values.service.internalApiPort }}"

    # Health server address.
    # This is an unencrypted endpoint useful for load balancers to check to healthiness of the clair server.
    healthaddr: "0.0.0.0:{{ .Values.service.internalHealthPort }}"

    # Deadline before an API request will respond with a 503.
    timeout: 900s

    # Optional PKI configuration.
    # If you want to easily generate client certificates and CAs, try the following projects:
    # https://github.com/coreos/etcd-ca
    # https://github.com/cloudflare/cfssl
    servername:
    cafile:
    keyfile:
    certfile:

  worker:
    namespace_detectors:
    {{- range $key, $value := .Values.config.enabledNamespaceDetectors }}
    - {{ $value }}
    {{- end }}

    feature_listers:
    {{- range $key, $value := .Values.config.enabledFeatureListers }}
    - {{ $value }}
    {{- end }}

  updater:
    # Frequency the database will be updated with vulnerabilities from the default data sources.
    # The value 0 disables the updater entirely.
    interval: "{{ .Values.config.updateInterval }}"
    enabledupdaters:
    {{- range $key, $value := .Values.config.enabledUpdaters }}
    - {{ $value }}
    {{- end }}

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
    # Number of attempts before the notification is marked as failed to be sent.
    attempts: 3

    # Duration before a failed notification is retried.
    renotifyinterval: 2h

    http:
      # Optional endpoint that will receive notifications via POST requests.
      endpoint: "{{ .Values.config.notificationWebhookEndpoint }}"

      # Optional PKI configuration.
      # If you want to easily generate client certificates and CAs, try the following projects:
      # https://github.com/cloudflare/cfssl
      # https://github.com/coreos/etcd-ca
      servername:
      cafile:
      keyfile:
      certfile:

      # Optional HTTP Proxy: must be a valid URL (including the scheme).
      proxy:
