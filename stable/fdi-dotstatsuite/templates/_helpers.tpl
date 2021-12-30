{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "dotstatsuite.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dotstatsuite.fullname" -}}
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
{{- define "dotstatsuite.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dotstatsuite.labels" -}}
helm.sh/chart: {{ include "dotstatsuite.chart" . }}
{{ include "dotstatsuite.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dotstatsuite.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dotstatsuite.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.authz.serviceAccountName" -}}
{{- if .Values.authz.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.authz.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.authz.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.nsiReset.serviceAccountName" -}}
{{- if .Values.nsiReset.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.nsiReset.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.nsiReset.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.nsiStable.serviceAccountName" -}}
{{- if .Values.nsiStable.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.nsiStable.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.nsiStable.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.nsiDesign.serviceAccountName" -}}
{{- if .Values.nsiDesign.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.nsiDesign.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.nsiDesign.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.nsiStaging.serviceAccountName" -}}
{{- if .Values.nsiStaging.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.nsiStaging.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.nsiStaging.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.transfer.serviceAccountName" -}}
{{- if .Values.transfer.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.transfer.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.transfer.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Database Host logic
*/}}
{{- define "dotstatsuite.databaseHost" -}}
{{- if index .Values "mssql-linux" "enabled" }}{{ .Release.Name }}-mssql-linux
{{- else }} {{ .Values.managed.database.server }}
{{- end }}
{{- end }}
