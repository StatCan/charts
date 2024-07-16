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
{{- define "dotstatsuite.config.serviceAccountName" -}}
{{- if .Values.config.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.config.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.config.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.dlm.serviceAccountName" -}}
{{- if .Values.dlm.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.dlm.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.dlm.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.sfs.serviceAccountName" -}}
{{- if .Values.sfs.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.sfs.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.sfs.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.solr.serviceAccountName" -}}
{{- if .Values.solr.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.solr.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.solr.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotstatsuite.mongo.serviceAccountName" -}}
{{- if .Values.mongo.serviceAccount.create }}
{{- default (include "dotstatsuite.fullname" .) .Values.mongo.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.mongo.serviceAccount.name }}
{{- end }}
{{- end }}

