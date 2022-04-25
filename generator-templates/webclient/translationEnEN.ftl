const translationEnEN = {
<#if app.entities??>
<#list app.entities as entity>
    "${entity.name?uncap_first}": "${entity.name}",
    "${entity.name?uncap_first}.title": "${entity.name}",
    "${entity.name?uncap_first}.create.title": "Create ${entity.name}",
    "${entity.name?uncap_first}.update.title": "Edit ${entity.name}",
    "${entity.name?uncap_first}.id": "id",
<#if entity.fields??>
<#list (entity.fields) as field> 
    "${entity.name?uncap_first}.${field.fieldName}": "${field.fieldName}",
    "${entity.name?uncap_first}.${field.fieldName}.hint": "has to match validation rules",
</#list>
</#if>
</#list>
</#if>
    "app.baseName": "${app.baseName}",
    "home.title": "Welcome",
    "home.welcome": "Welcome to ${app.baseName}",
    "button.submit": "OK",
    "button.create": "Add",
    "button.update": "Edit",
    "button.delete": "Delete"
};
export default translationEnEN;
