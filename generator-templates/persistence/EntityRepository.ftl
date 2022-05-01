package de.${app.packageName?lower_case}.persistence.repository;

import de.${app.packageName?lower_case}.persistence.entity.${entity.name}Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

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
