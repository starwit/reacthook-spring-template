const ${entity.name?uncap_first}Default = {
<#if entity.fields??>
<#list (entity.fields) as field> 
    ${field.fieldName}: "",
</#list>
</#if>
    id: undefined
};

const ${entity.name?uncap_first}Fields = [
<#if entity.fields??>
<#list (entity.fields) as field>
    {name: "${field.fieldName}", type: "${field.fieldType?lower_case}", regex: <#if field.fieldValidateRulesPattern??>${field.fieldValidateRulesPattern}<#else>null</#if>},
</#list>
</#if>
];

export {${entity.name?uncap_first}Default, ${entity.name?uncap_first}Fields};
