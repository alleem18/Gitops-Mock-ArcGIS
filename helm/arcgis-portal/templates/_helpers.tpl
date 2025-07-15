{{- define "arcgis-portal.name" -}}
arcgis-portal
{{- end }}

{{- define "arcgis-portal.fullname" -}}
{{ include "arcgis-portal.name" . }}
{{- end }}

