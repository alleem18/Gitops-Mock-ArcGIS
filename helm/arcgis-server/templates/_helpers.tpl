{{- define "arcgis-server.name" -}}
arcgis-server
{{- end }}

{{- define "arcgis-server.fullname" -}}
{{ include "arcgis-server.name" . }}
{{- end }}

