<#list app.getEntities() as domain>
CREATE TABLE IF NOT EXISTS `${entity.name?upper_case}`
(
    `ID`      bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    <#list entity.fields as field>
    <#if field.fieldType == "String"> 
    `${field.fieldName?upper_case}` varchar(255)<#if !field.required> NOT NULL </#if><#sep>,</#sep>
    <#--  <#if field.fieldValidateRulesMaxlength??>, length=${field.fieldValidateRulesMaxlength}</#if>)  -->
        </#if>
        <#if field.fieldType == "Integer">
    `${field.fieldName?upper_case}` int(11)<#if field.required> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if field.fieldType == "BigDecimal"> 
    `${field.fieldName?upper_case}` decimal(19,2)<#if field.required> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if field.fieldType == "Double">
    `${field.fieldName?upper_case}` double<#if field.required> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if field.fieldType == "Date">
    `${field.fieldName?upper_case}` date<#if field.required> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if field.fieldType == "Time">
    `${field.fieldName?upper_case}` time<#if field.required> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if field.fieldType == "Timestamp">
    `${field.fieldName?upper_case}` datetime<#if field.required> NOT NULL </#if><#sep>,</#sep>
        </#if>
    </#list>
);
</#list>
