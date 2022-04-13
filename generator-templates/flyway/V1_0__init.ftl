<#list app.domains as domain>
CREATE TABLE IF NOT EXISTS `${domain.name?upper_case}`
(
    `ID`      bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    <#list domain.getAttributes() as attribute>
        <#if attribute.dataType == "String" || attribute.dataType == "Enum"> 
    `${attribute.name?upper_case}` varchar(255)<#if !attribute.nullable> NOT NULL </#if><#sep>,</#sep>
    <#--  <#if attribute.max??>, length=${attribute.max}</#if>)  -->
        </#if>
        <#if attribute.dataType == "Integer">
    `${attribute.name?upper_case}` int(11)<#if !attribute.nullable> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if attribute.dataType == "BigDecimal"> 
    `${attribute.name?upper_case}` decimal(19,2)<#if !attribute.nullable> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if attribute.dataType == "Double">
    `${attribute.name?upper_case}` double<#if !attribute.nullable> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if attribute.dataType == "Date">
    `${attribute.name?upper_case}` date<#if !attribute.nullable> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if attribute.dataType == "Time">
    `${attribute.name?upper_case}` time<#if !attribute.nullable> NOT NULL </#if><#sep>,</#sep>
        </#if>
        <#if attribute.dataType == "Timestamp">
    `${attribute.name?upper_case}` datetime<#if !attribute.nullable> NOT NULL </#if><#sep>,</#sep>
        </#if>
    </#list>
);
</#list>
