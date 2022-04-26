<#list app.entities as entity>
CREATE TABLE IF NOT EXISTS `${entity.name?upper_case}`
(
<#if entity.fields??>
    <#list entity.fields as field>
    <#if field.fieldType == "String"> 
    `${field.fieldName?upper_case}` varchar(255)<#if !field.required> NOT NULL </#if>,
    <#--  <#if field.fieldValidateRulesMaxlength??>, length=${field.fieldValidateRulesMaxlength}</#if>)  -->
        </#if>
        <#if field.fieldType == "Integer">
    `${field.fieldName?upper_case}` int(11)<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "BigDecimal"> 
    `${field.fieldName?upper_case}` decimal(19,2)<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Double">
    `${field.fieldName?upper_case}` double<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Date">
    `${field.fieldName?upper_case}` date<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Time">
    `${field.fieldName?upper_case}` time<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Timestamp">
    `${field.fieldName?upper_case}` datetime<#if field.required> NOT NULL </#if>,
        </#if>
    </#list>
</#if>
<#if entity.relationships??>
  <#list entity.relationships as relation>
  <#if relation.relationshipType == "ManyToOne">
    `${relation.otherEntityName?upper_case}_ID` bigint,
  <#elseif relation.relationshipType == "OneToOne">
    <#if relation.ownerSide>
        `${relation.otherEntityName?upper_case}_ID` bigint,
    </#if>
  </#if>
  </#list>
</#if>
    `ID` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY
);

</#list>
<#list app.entities as entity>
<#if entity.relationships??>
  <#list entity.relationships as relation>
  <#if relation.relationshipType == "OneToMany">
  <#elseif relation.relationshipType == "ManyToOne">
    ALTER TABLE `${entity.name?upper_case}`
       ADD CONSTRAINT `FK_${entity.name?upper_case}_${relation.relationshipName?upper_case}`
       FOREIGN KEY (`${relation.otherEntityName?upper_case}_ID`) 
       REFERENCES `${relation.otherEntityName?upper_case}` (`ID`);

  <#elseif relation.relationshipType == "OneToOne">
    <#if relation.ownerSide>
    ALTER TABLE `${entity.name?upper_case}`
       ADD CONSTRAINT `FK_${entity.name?upper_case}_${relation.relationshipName?upper_case}`
       FOREIGN KEY (`${relation.otherEntityName?upper_case}_ID`) 
       REFERENCES `${relation.otherEntityName?upper_case}` (`ID`);

    <#else>
    </#if>
  <#elseif relation.relationshipType == "ManyToMany">
    <#if relation.ownerSide>
    ALTER TABLE `${entity.name?upper_case}_${relation.relationshipName?upper_case}`
       ADD CONSTRAINT `FK_${entity.name?upper_case}_${relation.relationshipName?upper_case}`
       FOREIGN KEY (`${entity.name?upper_case}_ID`) 
       REFERENCES `${entity.name?upper_case}` (`ID`);

    ALTER TABLE `${entity.name?upper_case}_${relation.relationshipName?upper_case}`
       ADD CONSTRAINT `FK_${relation.otherEntityName?upper_case}_${relation.relationshipName?upper_case}`
       FOREIGN KEY (`${relation.otherEntityName?upper_case}_ID`) 
       REFERENCES `${relation.otherEntityName?upper_case}` (`ID`);

    </#if>
  </#if>
  </#list>
</#if>
</#list>
