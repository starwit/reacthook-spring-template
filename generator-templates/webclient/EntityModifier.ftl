const entityDefault = {
<#if entity.fields??>
<#list (entity.fields) as field>
    <#if field.fieldType == "Enum">
    ${field.fieldName}: "",
    <#elseif field.fieldType == "Timestamp" || field.fieldType == "Date" || field.fieldType == "Time">
    ${field.fieldName}: null,
    <#else>
    ${field.fieldName}: "",
    </#if>
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
        notNull: <#if field.required>true<#else>false</#if>,
        enumName: "${field.enumDef.name?trim?uncap_first}",
        selectList: [<#list (field.enumDef.selectList) as enumItem>
            "${enumItem?trim}"<#sep>,</#sep></#list>
        ]
    },
    <#else>
    {
        name: "${field.fieldName}",
        type: "${field.fieldType?lower_case}",
        regex: <#if field.fieldValidateRulesPattern??>/^${field.fieldValidateRulesPattern}$/<#else>null</#if>,
        <#if field.fieldValidateRulesMin??>min: ${field.fieldValidateRulesMin},
        </#if><#if field.fieldValidateRulesMax??>max: ${field.fieldValidateRulesMax},
        </#if><#if field.fieldValidateRulesMinlength??>min: ${field.fieldValidateRulesMinlength},
        </#if><#if field.fieldValidateRulesMaxlength??>max: ${field.fieldValidateRulesMaxlength},
        </#if>notNull: <#if field.required>true<#else>false</#if>
    },
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
