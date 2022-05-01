package de.${app.packageName?lower_case}.persistence.repository;

<#assign additionalQueries = false >
<#assign importList = []>
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    <#assign additionalQueries = true>
    <#if importList?seq_contains(relation.otherEntityName)>
    <#else>
    <#assign importList = importList + [relation.otherEntityName]>
import de.${app.packageName?lower_case}.persistence.entity.${relation.otherEntityName}Entity;
    </#if>
  </#if>
  </#list>
</#if>
<#if additionalQueries>
import java.util.List;
</#if>
import org.springframework.data.jpa.repository.JpaRepository;
<#if additionalQueries>
import org.springframework.data.jpa.repository.Query;
</#if>
import org.springframework.stereotype.Repository;
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
  </#if>
  </#list>
</#if>

/**
 * ${entity.name} Repository class
 */
@Repository
public interface ${entity.name}Repository extends JpaRepository<${entity.name}Entity, Long> {


<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    @Query("SELECT e FROM ${entity.name} e WHERE e.${relation.relationshipName} IS NULL")
    public List<${entity.name}Entity> findAllWithout${relation.relationshipName?cap_first}();
  </#if>
  </#list>
</#if>


}
