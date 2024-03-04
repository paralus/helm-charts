{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ztka.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "ztka.labels" -}}
helm.sh/chart: {{ include "ztka.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: paralus
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end }}
{{- end }}

{{- define "ztka.kratos.hooks.labels" -}}
helm.sh/chart: {{ include "ztka.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/component: kratos
app.kubernetes.io/part-of: paralus
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "ztka.selectorLabels" -}}
app.kubernetes.io/name: {{ .image.name }}
app.kubernetes.io/instance: {{ .release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ztka.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-") .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Validate storage options
*/}}
{{- define "ztka.auditlogStorage" -}}
  {{- if eq .Values.auditLogs.storage "database" -}}
database
  {{- else if eq .Values.auditLogs.storage "elasticsearch" -}}
elasticsearch
  {{- else -}}
{{ required "A valid .Values.auditLogs.storage entry required!" .Values.auditLogs.storage }}
  {{- end -}}
{{- end}}

{{/*
Get Kratos public address.
*/}}
{{- define "ztka.kratos.publicAddr" -}}
  {{- if .Values.deploy.kratos.enable -}}
http://{{.Release.Name}}-kratos-public
  {{- else -}}
{{ required "A valid .Values.deploy.kratos.publicAddr entry required!" .Values.deploy.kratos.publicAddr }}
  {{- end -}}
{{- end }}

{{/*
Get Kratos admin address.
*/}}
{{- define "ztka.kratos.adminAddr" -}}
  {{- if .Values.deploy.kratos.enable -}}
http://{{.Release.Name}}-kratos-admin
  {{- else -}}
{{ required "A valid .Values.deploy.kratos.adminAddr entry required!" .Values.deploy.kratos.adminAddr }}
  {{- end -}}
{{- end }}

{{/*
Get Elasticsearch Address.
*/}}
{{- define "ztka.esAddr" -}}
  {{- if eq .Values.auditLogs.storage "elasticsearch" -}}
    {{- if .Values.deploy.elasticsearch.enable -}}
http://elasticsearch-master:9200
    {{- else -}}
{{ required "A valid .Values.deploy.elasticsearch.address entry required!" .Values.deploy.elasticsearch.address }}
    {{- end -}}
  {{- end -}}
{{- end }}

{{/*
Get DB Address.
*/}}
{{- define "ztka.dbAddr" -}}
  {{- if .Values.deploy.postgresql.enable -}}
{{.Release.Name}}-postgresql.{{.Release.Namespace}}.svc.cluster.local
  {{- else if empty .Values.deploy.postgresql.dsn -}}
{{ required "A valid .Values.deploy.postgresql.address entry required!" .Values.deploy.postgresql.address }}
  {{- end -}}
{{- end }}

{{/*
Get DB Username.
*/}}
{{- define "ztka.dbUser" -}}
  {{- if .Values.deploy.postgresql.enable -}}
{{.Values.postgresql.auth.username}}
  {{- else if empty .Values.deploy.postgresql.dsn -}}
{{ required "A valid .Values.deploy.postgresql.username entry required!" .Values.deploy.postgresql.username }}
  {{- end -}}
{{- end }}

{{/*
Get DB Password.
*/}}
{{- define "ztka.dbPassword" -}}
  {{- if .Values.deploy.postgresql.enable -}}
{{.Values.postgresql.auth.password}}
  {{- else if empty .Values.deploy.postgresql.dsn -}}
{{ required "A valid .Values.deploy.postgresql.password entry required!" .Values.deploy.postgresql.password }}
  {{- end -}}
{{- end }}

{{/*
Get DB Name.
*/}}
{{- define "ztka.dbName" -}}
  {{- if .Values.deploy.postgresql.enable -}}
{{.Values.postgresql.auth.database}}
  {{- else if empty .Values.deploy.postgresql.dsn -}}
{{ required "A valid .Values.deploy.postgresql.database entry required!" .Values.deploy.postgresql.database }}
  {{- end -}}
{{- end }}

{{/*
Get DSN
*/}}
{{- define "ztka.dsn" -}}
  {{- if .Values.deploy.postgresql.enable -}}
postgres://{{ .Values.postgresql.auth.username }}:{{ .Values.postgresql.auth.password }}@{{.Release.Name}}-postgresql.{{.Release.Namespace}}.svc.cluster.local:5432/{{ .Values.postgresql.auth.database }}?sslmode=disable
  {{- else if .Values.deploy.postgresql.dsn -}}
{{ .Values.deploy.postgresql.dsn }}
  {{- else -}}
{{- $username := required "A valid .Values.deploy.postgresql.username entry required!" .Values.deploy.postgresql.username -}}
{{- $password := required "A valid .Values.deploy.postgresql.password entry required!" .Values.deploy.postgresql.password -}}
{{- $address := required "A valid .Values.deploy.postgresql.address entry required!" .Values.deploy.postgresql.address -}}
{{- $database := required "A valid .Values.deploy.postgresql.database entry required!" .Values.deploy.postgresql.database -}}
postgres://{{ $username }}:{{ $password }}@{{ $address }}:5432/{{ $database }}?sslmode=disable
  {{- end -}}
{{- end }}


{{/*
Get console full-qualified domain.
*/}}
{{- define "ztka.consoleFQDN" -}}
{{.Values.fqdn.hostname}}.{{.Values.fqdn.domain}}
{{- end -}}

{{/*
Get console full-qualified domain with scheme.
*/}}
{{- define "ztka.consoleFQDNWithScheme" -}}
{{- $url := printf "%s.%s" .Values.fqdn.hostname .Values.fqdn.domain -}}
  {{- if .Values.deploy.contour.enable -}}
    {{- if .Values.deploy.contour.tls -}}
https://{{$url}}
    {{- else -}}
http://{{$url}}
    {{- end -}}
  {{- else if .Values.ingress.enabled -}}
    {{- if .Values.ingress.tls -}}
https://{{$url}}
    {{- else -}}
http://{{$url}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Get console full-qualified domain with port.
*/}}
{{- define "ztka.consoleFQDNWithPort" -}}
{{- $url := printf "%s.%s" .Values.fqdn.hostname .Values.fqdn.domain -}}
  {{- if .Values.deploy.contour.enable -}}
    {{- if .Values.deploy.contour.tls -}}
{{$url}}:443
    {{- else -}}
{{$url}}:80
    {{- end -}}
  {{- else if .Values.ingress.enabled -}}
    {{- if .Values.ingress.tls -}}
{{$url}}:443
    {{- else -}}
{{$url}}:80
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Get core-connector full-qualified domain.
*/}}
{{- define "ztka.coreConnectorFQDN" -}}
{{.Values.fqdn.coreConnectorSubdomain}}.{{.Values.fqdn.domain}}
{{- end -}}

{{/*
TCP port for connection.
*/}}
{{- define "ztka.tcpPort" -}}
  {{- $tcpPort := 443 -}}
  {{- if and  $.Values.contour.envoy.hostPorts .Values.contour.envoy.hostPorts.https -}}
    {{- $tcpPort = .Values.contour.envoy.hostPorts.https -}}
  {{- end -}}
{{ $tcpPort }}
{{- end -}}

{{/*
Get user full-qualified domain.
*/}}
{{- define "ztka.userFQDN" -}}
{{.Values.fqdn.userSubdomain}}.{{.Values.fqdn.domain}}
{{- end -}}

{{/*
Get paralus service with port that is endpoint for kratos after login webhook.
*/}}
{{- define "ztka.afterLoginWebhookWithPort" -}}
{{ $url := "http://localhost:11000"}}
{{- range .Values.services.paralus.ports -}}
  {{- if eq .name "http" -}}
{{- $url = printf "http://%s:%.0f"  $.Values.services.paralus.name .containerPort -}}
  {{- end -}}
{{- end -}}
{{ $url }}
{{- end -}}