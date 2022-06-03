/* eslint-disable max-len */
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
    "${entity.name?uncap_first}.${field.fieldName}": "${field.fieldName}<#if field.required>*</#if>",
    "${entity.name?uncap_first}.${field.fieldName}.hint": "<#if field.required>Value is required. </#if><#if field.fieldValidateRulesMin??>Allowed minimum is ${field.fieldValidateRulesMin}. </#if><#if field.fieldValidateRulesMax??>Allowed maximum is ${field.fieldValidateRulesMax}. </#if><#if field.fieldValidateRulesMinlength??>Allowed minimum length is ${field.fieldValidateRulesMinlength}. </#if><#if field.fieldValidateRulesMaxlength??>Allowed maximum length is ${field.fieldValidateRulesMaxlength}. </#if><#if field.fieldValidateRulesPattern??>Pattern ${field.fieldValidateRulesPattern} has to be matched. </#if>",
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
    "error.invalidDefinition": "Invalid definition.",
    "error.general.delete": "This element could not be deleted.",
    "error.general.create": "This element could not be created.",
    "error.general.update": "This element could not be updated.",
    "error.general.get": "This element could not be loaded.",
    "error.serverOffline": "The server seems to be offline.",
    "error.userOffline": "You appear to be offline.",
    "error.unknown": "An unknown error occurred.",
    "error.apptemplate.notfound": "The Template could not be found.",
    "error.app.notfound": "This App could not be found.",
    "error.entity.notfound": "This element could not be found.",
};
export default translationEnEN;
