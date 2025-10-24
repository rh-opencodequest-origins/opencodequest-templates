{{/*
Expand the name of the chart.
*/}}
{{- define "quarkus-template.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "quarkus-template.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "quarkus-template.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "backstage.labels" -}}
backstage.io/kubernetes-id: ${{values.user}}-${{values.component_id}}
{{- end }}

{{- define "quarkus-template.labels" -}}
backstage.io/kubernetes-id: ${{values.user}}-${{values.component_id}}
helm.sh/chart: {{ include "quarkus-template.chart" . }}
app.openshift.io/runtime: quarkus
{{ include "quarkus-template.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "quarkus-template-database.labels" -}}
backstage.io/kubernetes-id: ${{values.user}}-${{values.component_id}}
helm.sh/chart: {{ include "quarkus-template.chart" . }}
app.openshift.io/runtime: postgresql
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/instance: {{ .Release.Name }}-database
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "quarkus-template.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quarkus-template.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "quarkus-template.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "quarkus-template.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "quarkus-template.image" -}}
{{- if eq .Values.image.registry "Quay" }}
{{- printf "%s/%s/%s:%s" .Values.image.host .Values.image.organization .Values.image.name .Values.image.tag -}}
{{- else }}
{{- printf "%s/%s/%s:latest" .Values.image.host .Values.namespace.name .Values.image.name -}}
{{- end }}
{{- end }}

{{/*
Generate database password - reuses existing or creates new
*/}}
{{- define "quarkus-template.databasePassword" -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace (printf "%s-database" .Values.deployment_name) -}}
{{- if $secret -}}
{{- $secret.data.POSTGRESQL_PASSWORD | b64dec -}}
{{- else if and .Values.database .Values.database.password -}}
{{- .Values.database.password -}}
{{- else -}}
{{- randAlphaNum 16 -}}
{{- end -}}
{{- end -}}