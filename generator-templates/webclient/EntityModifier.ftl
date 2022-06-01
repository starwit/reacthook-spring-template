const entityDefault = {
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
    <#if field.fieldType == "Enum">
    {
        name: "${field.fieldName}",
        type: "${field.fieldType?lower_case}",
        regex: <#if field.fieldValidateRulesPattern??>/^${field.fieldValidateRulesPattern}$/<#else>null</#if>,
        selectList: [<#list (field.enumDef.selectList) as enumItem>
            "${enumItem?trim}"<#sep>,</#sep></#list>
        ]
    },
    <#else>
    {name: "${field.fieldName}", type: "${field.fieldType?lower_case}", regex: <#if field.fieldValidateRulesPattern??>/^${field.fieldValidateRulesPattern}$/<#else>null</#if>},
    </#if>
</#list>
</#if>
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
    <#if relation.ownerSide>
    {
        name: "${relation.relationshipName}",
        type: "${relation.relationshipType}",
        regex: null,
        selectList: [],
        display: [
      <#if app.entities??>
        <#list app.entities as otherEntity>
        <#if otherEntity.name == relation.otherEntityName>
        <#if otherEntity.fields??>
        <#list (otherEntity.fields) as field>
            "${field.fieldName}"<#sep>,</#sep>
        </#list>
        </#if>
        </#if>
        </#list>
      </#if>
        ],
        selectedIds: []
    }<#sep>,</#sep>
    </#if>
  </#list>
</#if>
];

const ${entity.name?uncap_first}OverviewFields = [
<#if entity.fields??>
<#list (entity.fields) as field>
    {name: "${field.fieldName}", type: "${field.fieldType?lower_case}", regex: <#if field.fieldValidateRulesPattern??>/^${field.fieldValidateRulesPattern}$/<#else>null</#if>}<#sep>,</#sep>
</#list>
</#if>
];

export {
    entityDefault,
    entityFields,
    ${entity.name?uncap_first}OverviewFields
};
