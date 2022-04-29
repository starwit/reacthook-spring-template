const EntityDefault = {
<#if entity.fields??>
<#list (entity.fields) as field> 
    ${field.fieldName}: "",
</#list>
</#if>
    id: undefined
};

const entityFields = [
<#if entity.fields??>
<#list (entity.fields) as field>
    {name: "${field.fieldName}", type: "${field.fieldType?lower_case}", regex: <#if field.fieldValidateRulesPattern??>/^${field.fieldValidateRulesPattern}$/<#else>null</#if>},
</#list>
</#if>
<#if entity.relationships??>
<#list (entity.relationships) as relation>
<#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne" || relation.relationshipType == "ManyToMany">
    {
        name: "${relation.relationshipName}",
        type: "${relation.relationshipType}",
        regex: null, 
        selectList: [],
        display: [
            "name"
        ],
        selectedIds: []
    },
</#if>
</#list>
</#if>
];

const ${entity.name?uncap_first}OverviewFields = [
<#if entity.fields??>
<#list (entity.fields) as field>
    {name: "${field.fieldName}", type: "${field.fieldType?lower_case}", regex: <#if field.fieldValidateRulesPattern??>/^${field.fieldValidateRulesPattern}$/<#else>null</#if>},
</#list>
</#if>
];

export {
    entityDefault,
    entityFields,
    ${entity.name?uncap_first}OverviewFields
};
