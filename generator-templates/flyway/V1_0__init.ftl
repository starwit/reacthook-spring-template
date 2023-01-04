<#list app.entities as entity>
CREATE SEQUENCE IF NOT EXISTS "${entity.name?lower_case}_id_seq";

CREATE TABLE "${entity.name?lower_case}"
(
<#if entity.fields??>
    <#list entity.fields as field>
    <#if field.fieldType == "String" || field.fieldType == "Enum">
    "${field.fieldName?lower_case}" VARCHAR(255)<#if field.required> NOT NULL </#if>,
    <#--  <#if field.fieldValidateRulesMaxlength??>, length=${field.fieldValidateRulesMaxlength}</#if>)  -->
        </#if>
        <#if field.fieldType == "Integer">
    "${field.fieldName?lower_case}" INTEGER<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "BigDecimal">
    "${field.fieldName?lower_case}" DECIMAL(19,2)<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Double">
    "${field.fieldName?lower_case}" DOUBLE<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Date">
    "${field.fieldName?lower_case}" DATE<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Time">
    "${field.fieldName?lower_case}" TIME<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Timestamp">
    "${field.fieldName?lower_case}" DATETIME<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Boolean">
    "${field.fieldName?lower_case}" BOOLEAN<#if field.required> NOT NULL </#if>,
        </#if>
        <#if field.fieldType == "Long">
    "${field.fieldName?lower_case}" BIGINT<#if field.required> NOT NULL </#if>,
        </#if>
    </#list>
</#if>
<#if entity.relationships??>
  <#list entity.relationships as relation>
  <#if relation.relationshipType == "ManyToOne">
    "${relation.otherEntityName?lower_case}_id" BIGINT,
  <#elseif relation.relationshipType == "OneToOne">
    <#if relation.ownerSide>
    "${relation.otherEntityName?lower_case}_id" BIGINT UNIQUE,
    </#if>
  </#if>
  </#list>
</#if>
    "id" BIGINT NOT NULL DEFAULT nextval('${entity.name?lower_case}_id_seq'),
    CONSTRAINT "${entity.name?lower_case}_pkey" PRIMARY KEY ("id")
);

</#list>
<#list app.entities as entity>
<#if entity.relationships??>
  <#list entity.relationships as relation>
  <#if relation.relationshipType == "OneToMany">
  <#elseif relation.relationshipType == "ManyToOne">
ALTER TABLE "${entity.name?lower_case}"
    ADD CONSTRAINT "fk_${entity.name?lower_case}_${relation.relationshipName?lower_case}"
    FOREIGN KEY ("${relation.otherEntityName?lower_case}_id")
    REFERENCES "${relation.otherEntityName?lower_case}" ("id");

  <#elseif relation.relationshipType == "OneToOne">
    <#if relation.ownerSide>
ALTER TABLE "${entity.name?lower_case}"
    ADD CONSTRAINT "fk_${entity.name?lower_case}_${relation.relationshipName?lower_case}"
    FOREIGN KEY ("${relation.otherEntityName?lower_case}_id")
    REFERENCES "${relation.otherEntityName?lower_case}" ("id");

    <#else>
    </#if>
  <#elseif relation.relationshipType == "ManyToMany">
    <#if relation.ownerSide>
CREATE TABLE "${entity.name?lower_case}_${relation.relationshipName?lower_case}" (
    "${entity.name?lower_case}_id" BIGINT NOT NULL,
    "${relation.otherEntityName?lower_case}_id" BIGINT NOT NULL,
    PRIMARY KEY ("${entity.name?lower_case}_id", "${relation.otherEntityName?lower_case}_id")
);

ALTER TABLE "${entity.name?lower_case}_${relation.relationshipName?lower_case}"
    ADD CONSTRAINT "fk_${entity.name?lower_case}_${relation.relationshipName?lower_case}"
    FOREIGN KEY ("${entity.name?lower_case}_id")
    REFERENCES "${entity.name?lower_case}" ("id");

ALTER TABLE "${entity.name?lower_case}_${relation.relationshipName?lower_case}"
    ADD CONSTRAINT "fk_${relation.otherEntityName?lower_case}_${relation.relationshipName?lower_case}"
    FOREIGN KEY ("${relation.otherEntityName?lower_case}_id")
    REFERENCES "${relation.otherEntityName?lower_case}" ("id");

    </#if>
  </#if>
  </#list>
</#if>
</#list>
