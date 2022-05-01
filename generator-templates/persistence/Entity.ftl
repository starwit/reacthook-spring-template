package de.${app.packageName?lower_case}.persistence.entity;

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
    @Column(name = "${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if><#if field.max??>, length=${field.max}</#if>)
        </#if>
        <#if field.fieldType == "Integer"> 
    @Column(name = "${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "BigDecimal"> 
    @Column(name = "${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "Double"> 
    @Column(name = "${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
        </#if>
        <#if field.fieldType == "Enum"> 
    @Enumerated(EnumType.STRING)
    @Column(name = "${field.fieldName?upper_case}"<#if field.required>, nullable = false</#if>)
        </#if>
    private ${field.fieldType} ${field.fieldName};

  </#if>
  </#list>
</#if>
<#if entity.relationships??>
    // entity relations
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToMany">
    @OneToMany(mappedBy = "${relation.otherEntityRelationshipName}")
    private Set<${relation.otherEntityName}Entity> ${relation.relationshipName};

  <#elseif relation.relationshipType == "ManyToOne">
    @ManyToOne
    @JoinColumn(name = "${relation.otherEntityName?upper_case}_ID")
    private ${relation.otherEntityName}Entity ${relation.relationshipName};

  <#elseif relation.relationshipType == "OneToOne">
    <#if relation.ownerSide>
    @JsonFilter("filterId")
    @OneToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "${relation.otherEntityName?upper_case}_ID", referencedColumnName = "ID", unique = true)
    private ${relation.otherEntityName}Entity ${relation.relationshipName};

    <#else>
    @JsonFilter("filterId")
    @OneToOne(mappedBy = "${relation.otherEntityRelationshipName}")
    private ${relation.otherEntityName}Entity ${relation.relationshipName};

    </#if>
  <#elseif relation.relationshipType == "ManyToMany">
    <#if relation.ownerSide>
    @JsonFilter("filterId")
    @ManyToMany(cascade = CascadeType.REFRESH)
    @JoinTable(
        name = "${entity.name?upper_case}_${relation.relationshipName?upper_case}", 
        joinColumns = @JoinColumn(name = "${entity.name?upper_case}_ID"), 
        inverseJoinColumns = @JoinColumn(name = "${relation.otherEntityName?upper_case}_ID"))
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

  <#elseif relation.relationshipType == "OneToMany" || relation.relationshipType == "OneToOne">
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
