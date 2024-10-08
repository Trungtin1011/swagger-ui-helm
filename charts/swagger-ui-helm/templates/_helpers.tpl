{{/*
Expand the name of the chart.
*/}}
{{- define "swagger.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "swagger.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "swagger.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common Swagger UI labels
*/}}
{{- define "swagger.labels" -}}
helm.sh/chart: {{ include "swagger.chart" . }}
{{ include "swagger.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common Swagger Validator labels
*/}}
{{- define "swaggervalidator.labels" -}}
helm.sh/chart: {{ include "swagger.chart" . }}
{{ include "swaggervalidator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Swagger UI Selector labels
*/}}
{{- define "swagger.selectorLabels" -}}
app.kubernetes.io/name: {{ include "swagger.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Swagger Validator Selector labels
*/}}
{{- define "swaggervalidator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "swagger.name" . }}-validator
app.kubernetes.io/instance: {{ .Release.Name }}-validator
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "swagger.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "swagger.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
