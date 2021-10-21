{{- /*
local_or_global returns a global value if available, otherwise returns the local one
*/}}

{{ define "local_or_global" }}

    {{ $value_path := index . 0 }}
    {{ $parts := splitList "." $value_path }}
    {{ $values := "" }}
    {{ $val := "" }}
    {{ $count := 0 }}

    {{ with index . 1 }}
        {{ if .Values.global }}
            {{ $values = .Values.global }}
        {{ else -}}
            {{ $values = .Values }}
        {{ end }}

        {{ range $parts }}
            {{ if not $count }}
                {{ $val = index $values (printf "%s" (index $parts $count)) }}
            {{ else }}
                {{ $val = index $val (printf "%s" (index $parts $count)) }}
            {{ end }}
            {{ $count = add $count 1 }}
        {{ end }}

        {{ print $val }}

    {{ end }}
{{ end }}
