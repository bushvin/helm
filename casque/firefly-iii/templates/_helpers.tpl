{{/*
Copyright William Leemans. All rights Reserved
SPDX-License-Identifier: GPL-3.0-or-later
*/}}

{{/* vim: set filetype=mustache: */}}

{{/*
Fail fast if both .Values.config.cronjob.auth.token and
.Values.config.cronjob.auth.existingSecret are defined
*/}}
{{- if and .Values.config.cronjob.auth.token .Values.config.cronjob.auth.existingSecret }}
{{- print "You must only define one of .Values.config.cronjob.auth.token or .Values.config.cronjob.auth.existingSecret, not both!" | fail }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "firefly-iii.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Chart Fullname
*/}}
{{- define "firefly-iii.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | replace "+" "_" | trimSuffix "-" | trunc 63 }}
{{- end }}

{{/*
Chart name and version
*/}}
{{- define "firefly-iii.chart" -}}
{{- printf "%.53s" .Chart.Name | replace "+" "_" | trimSuffix "-" }}-{{ .Chart.Version }}
{{- end }}

{{/*
Return proper firefly-iii web image
*/}}
{{- define "firefly-iii.web.image" -}}
{{- .Values.web.image.repository | default "fireflyiii/core" }}:{{ .Values.web.image.tag | default "latest"  }}
{{- end -}}

{{/*
Return proper firefly-iii cron image
*/}}
{{- define "firefly-iii.cron.image" -}}
{{- default "curlimages/curl" .Values.cronjob.image.repository }}:{{ default "latest" .Values.cronjob.image.tag }}
{{- end -}}

{{/*
Labels
*/}}
{{- define "firefly-iii.labels" -}}
{{ include "firefly-iii.selectorLabels" . }}
helm.sh/chart: {{ include "firefly-iii.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector Labels
*/}}
{{- define "firefly-iii.selectorLabels" -}}
app.kubernetes.io/name: {{ include "firefly-iii.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

