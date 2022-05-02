package de.${app.packageName?lower_case}.persistence.repository;

<#assign additionalQueries = false >
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    <#assign additionalQueries = true>
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
<#if additionalQueries>
import de.${app.packageName?lower_case}.persistence.entity.${entity.name}Entity;
</#if>

/**
 * ${entity.name} Repository class
 */
@Repository
public interface ${entity.name}Repository extends JpaRepository<${entity.name}Entity, Long> {

<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    @Query("SELECT e FROM ${entity.name}Entity e WHERE e.${relation.relationshipName} IS NULL")
    public List<${entity.name}Entity> findAllWithout${relation.relationshipName?cap_first}();
  </#if>
  </#list>
</#if>
}
