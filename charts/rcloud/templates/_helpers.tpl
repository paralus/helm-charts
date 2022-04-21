{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rcloud.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "rcloud.labels" -}}
helm.sh/chart: {{ include "rcloud.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "rcloud.selectorLabels" -}}
app.kubernetes.io/name: {{ .image.name }}
app.kubernetes.io/instance: {{ .release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rcloud.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-") .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get Kratos public address.
*/}}
{{- define "rcloud.kratos.publicAddr" -}}
  {{- if .Values.deploy.kratos.enable -}}
http://{{.Release.Name}}-kratos-public
  {{- else -}}
{{ required "A valid .Values.deploy.kratos.publicAddr entry required!" .Values.deploy.kratos.publicAddr }}
  {{- end -}}
{{- end }}

{{/*
Get Kratos admin address.
*/}}
{{- define "rcloud.kratos.adminAddr" -}}
  {{- if .Values.deploy.kratos.enable -}}
http://{{.Release.Name}}-kratos-admin
  {{- else -}}
{{ required "A valid .Values.deploy.kratos.adminAddr entry required!" .Values.deploy.kratos.adminAddr }}
  {{- end -}}
{{- end }}

{{/*
Get Elasticsearch Address.
*/}}
{{- define "rcloud.esAddr" -}}
  {{- if .Values.deploy.elasticsearch.enable -}}
elasticsearch-master
  {{- else -}}
{{ required "A valid .Values.deploy.elasticsearch.address entry required!" .Values.deploy.elasticsearch.address }}
  {{- end -}}
{{- end }}

{{/*
Get DB Address.
*/}}
{{- define "rcloud.dbAddr" -}}
  {{- if .Values.deploy.postgresql.enable -}}
{{.Release.Name}}-postgresql.{{.Release.Namespace}}.svc.cluster.local
  {{- else -}}
{{ required "A valid .Values.deploy.postgresql.address entry required!" .Values.deploy.postgresql.address }}
  {{- end -}}
{{- end }}

{{/*
Get DB Username.
*/}}
{{- define "rcloud.dbUser" -}}
  {{- if .Values.deploy.postgresql.enable -}}
{{.Values.postgresql.auth.username}}
  {{- else -}}
{{ required "A valid .Values.deploy.postgresql.username entry required!" .Values.deploy.postgresql.username }}
  {{- end -}}
{{- end }}

{{/*
Get DB Password.
*/}}
{{- define "rcloud.dbPassword" -}}
  {{- if .Values.deploy.postgresql.enable -}}
{{.Values.postgresql.auth.password}}
  {{- else -}}
{{ required "A valid .Values.deploy.postgresql.password entry required!" .Values.deploy.postgresql.password }}
  {{- end -}}
{{- end }}

{{/*
Get DB Name.
*/}}
{{- define "rcloud.dbName" -}}
  {{- if .Values.deploy.postgresql.enable -}}
{{.Values.postgresql.auth.database}}
  {{- else -}}
{{ required "A valid .Values.deploy.postgresql.database entry required!" .Values.deploy.postgresql.database }}
  {{- end -}}
{{- end }}

{{/*
Get DSN
*/}}
{{- define "rcloud.dsn" -}}
  {{- if .Values.deploy.postgresql.enable -}}
postgres://{{ .Values.postgresql.auth.username }}:{{ .Values.postgresql.auth.password }}@{{.Release.Name}}-postgresql.{{.Release.Namespace}}.svc.cluster.local:5432/{{ .Values.postgresql.auth.database }}?sslmode=disable
  {{- else -}}
{{- $username := required "A valid .Values.deploy.postgresql.username entry required!" .Values.deploy.postgresql.username -}}
{{- $password := required "A valid .Values.deploy.postgresql.password entry required!" .Values.deploy.postgresql.password -}}
{{- $address := required "A valid .Values.deploy.postgresql.address entry required!" .Values.deploy.postgresql.address -}}
{{- $database := required "A valid .Values.deploy.postgresql.database entry required!" .Values.deploy.postgresql.database -}}
postgres://{{ $username }}:{{ $.password }}@{{ $address }}:5432/{{ $database }}?sslmode=disable
  {{- end -}}
{{- end }}


{{/*
Get console full-qualified domain with scheme.
TODO: Domain name when ingress disabled.
*/}}
{{- define "rcloud.consoleFQDNWithScheme" -}}
{{- if .Values.ingress.tls -}}
https://{{.Values.ingress.consoleSubdomain}}.{{.Values.ingress.host}}
{{- else -}}
http://{{.Values.ingress.consoleSubdomain}}.{{.Values.ingress.host}}
{{- end -}}
{{- end -}}

{{/*
Get console full-qualified domain.
*/}}
{{- define "rcloud.consoleFQDN" -}}
{{.Values.ingress.consoleSubdomain}}.{{.Values.ingress.host}}
{{- end -}}

{{/*
Get core-connector full-qualified domain.
*/}}
{{- define "rcloud.coreConnectorFQDN" -}}
{{.Values.ingress.coreConnectorSubdomain}}.{{.Values.ingress.host}}
{{- end -}}

{{/*
Get user full-qualified domain.
*/}}
{{- define "rcloud.userFQDN" -}}
{{.Values.ingress.userSubdomain}}.{{.Values.ingress.host}}
{{- end -}}
