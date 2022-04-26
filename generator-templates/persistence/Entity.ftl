package de.${app.packageName?lower_case}.persistence.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

<#list (imports) as import> 
${import}
</#list>

/**
 * ${entity.name} Entity class
 */
@XmlRootElement
@Entity
@Table(name = "${entity.name?upper_case}")
public class ${entity.name}Entity extends AbstractEntity<Long> {

//entity fields
<#if entity.fields??>
    <#list (entity.fields) as field> 
        <#if field.fieldValidateRulesPattern?? && field.fieldValidateRulesPattern?length &gt; 0 && field.fieldType == "String">
    @Pattern(regexp = "${field.fieldValidateRulesPattern}")
        </#if>    
        <#if field.fieldType == "String">
            <#if field.required>
    @NotBlank
            </#if>
            <#if field.fieldValidateRulesMinlength?? && field.fieldValidateRulesMaxlength??>
    @Length(min = ${field.fieldValidateRulesMinlength}, max = ${field.fieldValidateRulesMaxlength})
            </#if>
            <#if field.fieldValidateRulesMinlength?? && !field.fieldValidateRulesMaxlength??>
    @Size(min = ${field.fieldValidateRulesMinlength})
            </#if>
            <#if !field.fieldValidateRulesMinlength?? && field.fieldValidateRulesMaxlength??>
    @Size(max = ${field.mfieldValidateRulesMaxlengthax})
            </#if>
        <#else>
            <#if field.required>
    @NotNull
            </#if>
            <#if field.fieldValidateRulesMin??>
    @Min(value = ${field.fieldValidateRulesMin})
            </#if>
            <#if field.fieldValidateRulesMax??>
    @Max(value = ${field.fieldValidateRulesMax})
            </#if>
        </#if>
    <#if field.fieldType == "Date" || field.fieldType == "Time" || field.fieldType == "Timestamp">
    @Temporal(TemporalType.${field.fieldType?upper_case})
    @Column(name="${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
    private Date ${field.fieldName};
    <#else>
        <#if field.fieldType == "String"> 
    @Column(name="${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if><#if field.max??>, length=${field.max}</#if>)
        </#if>
        <#if field.fieldType == "Integer"> 
    @Column(name="${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "BigDecimal"> 
    @Column(name="${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "Double"> 
    @Column(name="${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "Enum"> 
    @Enumerated(EnumType.STRING)
    @Column(name="${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
        </#if>
    private ${field.fieldType} ${field.fieldName};

    </#if>
    </#list>

</#if>
  <#list (entity.fields) as field> 
        <#if field.fieldType == "Date" || field.fieldType == "Time" || field.fieldType == "Timestamp"> 
    public Date get${field.fieldName?cap_first}() {
        return ${field.fieldName};
    }

    public void set${field.fieldName?cap_first}(Date ${field.fieldName}) {
        this.${field.fieldName} = ${field.fieldName};
    }
        <#else>
    public ${field.fieldType} get${field.fieldName?cap_first}() {
        return ${field.fieldName};
    }

    public void set${field.fieldName?cap_first}(${field.fieldType} ${field.fieldName}) {
        this.${field.fieldName} = ${field.fieldName};
    }

        </#if>
    </#list>
}
