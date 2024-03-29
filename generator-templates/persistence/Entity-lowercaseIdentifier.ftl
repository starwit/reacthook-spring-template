package de.${app.packageName?lower_case}.persistence.entity;

<#list (imports) as import>
${import}
</#list>

import java.time.ZonedDateTime;
import de.${app.packageName?lower_case}.persistence.serializer.ZonedDateTimeSerializer;
import de.${app.packageName?lower_case}.persistence.serializer.ZonedDateTimeDeserializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import jakarta.persistence.CascadeType;

/**
 * ${entity.name} Entity class
 */
@Entity
@Table(name = "${entity.name?lower_case}")
public class ${entity.name}Entity extends AbstractEntity<Long> {

<#if entity.fields??>
    // entity fields
  <#list (entity.fields) as field>
  <#if field.fieldValidateRulesPattern?? && field.fieldValidateRulesPattern?length &gt; 0 && field.fieldType == "String">
    @Pattern(regexp = "${field.fieldValidateRulesPattern}")
  </#if>
  <#if field.fieldType == "String">
            <#if field.required>
    @NotBlank
            </#if>
            <#if field.fieldValidateRulesMinlength?? && field.fieldValidateRulesMaxlength??>
    @Size(min = ${field.fieldValidateRulesMinlength}, max = ${field.fieldValidateRulesMaxlength})
            </#if>
            <#if field.fieldValidateRulesMinlength?? && !field.fieldValidateRulesMaxlength??>
    @Size(min = ${field.fieldValidateRulesMinlength})
            </#if>
            <#if !field.fieldValidateRulesMinlength?? && field.fieldValidateRulesMaxlength??>
    @Size(max = ${field.fieldValidateRulesMaxlength})
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
    @Column(name="${field.fieldName?lower_case}"<#if field.required>, nullable = false</#if>)
    @JsonSerialize(using = ZonedDateTimeSerializer.class)
    @JsonDeserialize(using = ZonedDateTimeDeserializer.class)
    private ZonedDateTime ${field.fieldName};

  <#else>
        <#if field.fieldType == "String">
    @Column(name = "${field.fieldName?lower_case}"<#if field.required>, nullable = false</#if><#if field.max??>, length=${field.max}</#if>)
        </#if>
        <#if field.fieldType == "Integer">
    @Column(name = "${field.fieldName?lower_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "BigDecimal">
    @Column(name = "${field.fieldName?lower_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "Double">
    @Column(name = "${field.fieldName?lower_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "Long">
    @Column(name = "${field.fieldName?lower_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "Enum">
    @Enumerated(EnumType.STRING)
    @Column(name = "${field.fieldName?lower_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "Boolean">
    @Column(name = "${field.fieldName?lower_case}")
        </#if>
        <#if field.fieldType == "Enum">
    private ${field.enumDef.name} ${field.fieldName};

        <#else>
    private ${field.fieldType} ${field.fieldName};

        </#if>
  </#if>

  </#list>
</#if>
<#if entity.relationships??>
    // entity relations
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToMany">
    @JsonFilter("filterId")
    @OneToMany(mappedBy = "${relation.otherEntityRelationshipName}")
    private Set<${relation.otherEntityName}Entity> ${relation.relationshipName};

  <#elseif relation.relationshipType == "ManyToOne">
    @JsonFilter("filterId")
    @ManyToOne
    @JoinColumn(name = "${relation.otherEntityName?lower_case}_id")
    private ${relation.otherEntityName}Entity ${relation.relationshipName};

  <#elseif relation.relationshipType == "OneToOne">
    <#if relation.ownerSide>
    @JsonFilter("filterId")
    @OneToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "${relation.otherEntityName?lower_case}_id", referencedColumnName = "id", unique = true)
    private ${relation.otherEntityName}Entity ${relation.relationshipName};

    <#else>
    @OneToOne(mappedBy = "${relation.otherEntityRelationshipName}")
    private ${relation.otherEntityName}Entity ${relation.relationshipName};

    </#if>
  <#elseif relation.relationshipType == "ManyToMany">
    <#if relation.ownerSide>
    @JsonFilter("filterId")
    @ManyToMany(cascade = CascadeType.REFRESH)
    @JoinTable(
        name = "${entity.name?lower_case}_${relation.relationshipName?lower_case}",
        joinColumns = @JoinColumn(name = "${entity.name?lower_case}_id"),
        inverseJoinColumns = @JoinColumn(name = "${relation.otherEntityName?lower_case}_id"))
    private Set<${relation.otherEntityName}Entity> ${relation.relationshipName};

    <#else>
    @JsonFilter("filterId")
    @ManyToMany(mappedBy = "${relation.otherEntityRelationshipName}")
    private Set<${relation.otherEntityName}Entity> ${relation.relationshipName};

    </#if>
  </#if>
  </#list>
</#if>
<#if entity.fields??>
    // entity fields getters and setters
  <#list (entity.fields) as field>
  <#if field.fieldType == "Date" || field.fieldType == "Time" || field.fieldType == "Timestamp">
    public ZonedDateTime get${field.fieldName?cap_first}() {
        return ${field.fieldName};
    }

    public void set${field.fieldName?cap_first}(ZonedDateTime ${field.fieldName}) {
        this.${field.fieldName} = ${field.fieldName};
    }

  <#elseif field.fieldType == "Enum">
    public ${field.enumDef.name} get${field.fieldName?cap_first}() {
        return ${field.fieldName};
    }

    public void set${field.fieldName?cap_first}(${field.enumDef.name} ${field.fieldName}) {
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
</#if>
<#if entity.relationships??>
    // entity relations getters and setters
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToMany" || relation.relationshipType == "ManyToMany">
    public Set<${relation.otherEntityName}Entity> get${relation.relationshipName?cap_first}() {
        return ${relation.relationshipName};
    }

    public void set${relation.relationshipName?cap_first}(Set<${relation.otherEntityName}Entity> ${relation.relationshipName}) {
        this.${relation.relationshipName} = ${relation.relationshipName};
    }

  <#elseif relation.relationshipType == "ManyToOne" || relation.relationshipType == "OneToOne">
    public ${relation.otherEntityName}Entity get${relation.relationshipName?cap_first}() {
        return ${relation.relationshipName};
    }

    public void set${relation.relationshipName?cap_first}(${relation.otherEntityName}Entity ${relation.relationshipName}) {
        this.${relation.relationshipName} = ${relation.relationshipName};
    }

  </#if>
  </#list>
</#if>
}
