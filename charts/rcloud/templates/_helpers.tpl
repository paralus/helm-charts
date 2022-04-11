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
Get DSN
*/}}
{{- define "rcloud.dsn" -}}
  {{- if .Values.dependency.postgresql.enabled -}}
postgres://{{ .Values.postgresql.auth.username }}:{{ .Values.postgresql.auth.password }}@{{.Release.Name}}-postgresql.{{.Release.Namespace}}.svc.cluster.local:5432/{{ .Values.postgresql.auth.database }}?sslmode=disable
  {{- else if .Values.postgresql.dbAddr -}}
postgres://{{ .Values.postgresql.auth.username }}:{{ .Values.postgresql.auth.password }}@{{ .Values.postgresql.dbAddr }}:5432/{{ .Values.postgresql.auth.database }}?sslmode=disable
  {{- else -}}
TODO(user): add-db-address
  {{- end -}}
{{- end }}

{{/*
Get Kratos Address
*/}}
{{- define "rcloud.kratosAddr" -}}
  {{- if .Values.dependency.kratos.enabled -}}
http://{{.Release.Name}}-kratos-admin
  {{- else if .Values.kratos.kratosAddr -}}
{{ .Values.kratos.kratosAddr }}
  {{- else -}}
TODO(user): add-kratos-address
  {{- end -}}
{{- end }}

{{/*
Get DB Address
*/}}
{{- define "rcloud.dbAddr" -}}
  {{- if .Values.dependency.postgresql.enabled -}}
{{.Release.Name}}-postgresql.{{.Release.Namespace}}.svc.cluster.local
  {{- else if .Values.postgresql.dbAddr -}}
{{ .Values.postgresql.dbAddr }}
  {{- else -}}
TODO(user): add-db-address
  {{- end -}}
{{- end }}

{{/*
Get Elasticsearch Address
*/}}
{{- define "rcloud.esAddr" -}}
  {{- if .Values.dependency.elasticsearch.enabled -}}
elasticsearch-master
  {{- else if .Values.elasticsearch.esAddr -}}
{{ .Values.elasticsearch.esAddr }}
  {{- else -}}
TODO(user): add-es-address
  {{- end -}}
{{- end }}