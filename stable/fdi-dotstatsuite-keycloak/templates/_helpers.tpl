{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "fdi-dotstatsuite-keycloak.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fdi-dotstatsuite-keycloak.fullname" -}}
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
{{- define "fdi-dotstatsuite-keycloak.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fdi-dotstatsuite-keycloak.labels" -}}
helm.sh/chart: {{ include "fdi-dotstatsuite-keycloak.chart" . }}
{{ include "fdi-dotstatsuite-keycloak.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fdi-dotstatsuite-keycloak.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fdi-dotstatsuite-keycloak.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite-keycloak.keycloak.serviceAccountName" -}}
{{- if .Values.keycloak.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite-keycloak.fullname" .) .Values.keycloak.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.keycloak.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fdi-dotstatsuite-keycloak.proxy.serviceAccountName" -}}
{{- if .Values.proxy.serviceAccount.create }}
{{- default (include "fdi-dotstatsuite-keycloak.fullname" .) .Values.proxy.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.proxy.serviceAccount.name }}
{{- end }}
{{- end }}

