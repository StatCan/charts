{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "fdi-dotstatsuite.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fdi-dotstatsuite.fullname" -}}
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
{{- define "fdi-dotstatsuite.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fdi-dotstatsuite.labels" -}}
helm.sh/chart: {{ include "fdi-dotstatsuite.chart" . }}
{{ include "fdi-dotstatsuite.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fdi-dotstatsuite.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fdi-dotstatsuite.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.authz.serviceAccountName" -}}
{{- if .Values.authz.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.authz.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.authz.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiResetSdmx.serviceAccountName" -}}
{{- if .Values.fdiResetSdmx.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiResetSdmx.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiResetSdmx.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiStableSdmx.serviceAccountName" -}}
{{- if .Values.fdiStableSdmx.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiStableSdmx.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiStableSdmx.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiResetCkan.serviceAccountName" -}}
{{- if .Values.fdiResetCkan.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiResetCkan.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiResetCkan.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiStableCkan.serviceAccountName" -}}
{{- if .Values.fdiStableCkan.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiStableCkan.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiStableCkan.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiResetCcei.serviceAccountName" -}}
{{- if .Values.fdiResetCcei.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiResetCcei.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiResetCcei.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiStableCcei.serviceAccountName" -}}
{{- if .Values.fdiStableCcei.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiStableCcei.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiStableCcei.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiResetCensus.serviceAccountName" -}}
{{- if .Values.fdiResetCensus.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiResetCensus.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiResetCensus.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiStableCensus.serviceAccountName" -}}
{{- if .Values.fdiStableCensus.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiStableCensus.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiStableCensus.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiResetGeese.serviceAccountName" -}}
{{- if .Values.fdiResetGeese.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiResetGeese.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiResetGeese.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiStableGeese.serviceAccountName" -}}
{{- if .Values.fdiStableGeese.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiStableGeese.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiStableGeese.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiResetCodr.serviceAccountName" -}}
{{- if .Values.fdiResetCodr.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiResetCodr.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiResetCodr.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.fdiStableCodr.serviceAccountName" -}}
{{- if .Values.fdiStableCodr.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.fdiStableCodr.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.fdiStableCodr.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.transfer.serviceAccountName" -}}
{{- if .Values.transfer.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.transfer.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.transfer.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite.transfernoauth.serviceAccountName" -}}
{{- if .Values.transfernoauth.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite.fullname" .) .Values.transfernoauth.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.transfernoauth.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Database Host logic
*/}}
{{- define "fdi-dotstatsuite.databaseHost" -}}
{{- if index .Values "mssql-linux" "enabled" }}{{ .Chart.Name }}-mssql-linux
{{- else }}fdi-dotstatsuite.database.windows.net
{{- end }}
{{- end }}
