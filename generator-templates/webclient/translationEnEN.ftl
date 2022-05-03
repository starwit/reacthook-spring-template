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
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
    <#if relation.ownerSide>
    "${entity.name?uncap_first}.${relation.relationshipName}": "${relation.relationshipName}",
    </#if>
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
    "button.delete": "Delete",
    "select.none": "None",
    "error.inUse": "More than one row with the given identifier was found",
    "error.sqlIntegrityConstaint": "Given data is not in the right format to be saved. Please check related entries.",
    "error.unique": "Entry is already related do another object. Please create a new entry or delete existing relation.",
    "error.internalServerError": "Internal server error.",
    "error.accessdenied": "Access denied.",
    "error.notexists": "Selected entry does not exist.",
    "error.notfound": "Selected entry does not exist.",
    "error.badrequest": "Check if there is an unvalid ID declared while object shoud be created.",
    "error.wrongInputValue": "Wrong input value.",
    "error.unauthorized": "Unauthorized request.",
    "error.invalidDefinition": "Invalid definition."
};
export default translationEnEN;
