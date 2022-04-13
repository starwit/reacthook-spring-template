<#list app.domains as domain>
    "${domain.name?uncap_first}": "${domain.name}",
    "${domain.name?uncap_first}.title": "${domain.name}All",
    "${domain.name?uncap_first}.id": "id",
<#list (domain.attributes) as attribute> 
	"${domain.name?uncap_first}.${attribute.name}": "${attribute.name}",
</#list>
</#list>
