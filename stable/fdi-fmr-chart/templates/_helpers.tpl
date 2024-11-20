{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "fusionsuite.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fusionsuite.fullname" -}}
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
{{- define "fusionsuite.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fusionsuite.labels" -}}
helm.sh/chart: {{ include "fusionsuite.chart" . }}
{{ include "fusionsuite.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fusionsuite.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fusionsuite.name" . }}
app.kubernetes.io/instance: {{ include "fusionsuite.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fusionsuite.fusionapps.serviceAccountName" -}}
{{- if .Values.fusionapps.serviceAccount.create }}
{{- default (include "fusionsuite.fullname" .) .Values.fusionapps.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fusionapps.serviceAccount.name }}
{{- end }}
{{- end }}

