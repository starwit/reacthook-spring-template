const translationEnEN = {
<#if app.entities??>
<#list app.entities as entity>
    "${entity.name?uncap_first}": "${entity.name}",
    "${entity.name?uncap_first}.title": "${entity.name}All",
    "${entity.name?uncap_first}.id": "id",
<#if entity.fields??>
<#list (entity.fields) as field> 
    "${entity.name?uncap_first}.${field.fieldName}": "${field.fieldName}",
</#list>
</#if>
</#list>
</#if>
    "app.baseName": "${app.baseName}",
    "home.title": "Welcome",
    "home.welcome": "Welcome to ${app.baseName}"
};
export default translationEnEN;
