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
