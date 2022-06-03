package de.${app.packageName?lower_case}.service.impl;
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
import de.${app.packageName?lower_case}.persistence.entity.${entity.name}Entity;
import de.${app.packageName?lower_case}.persistence.repository.${entity.name}Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 
 * ${entity.name} Service class
 *
 */
@Service
public class ${entity.name}Service implements ServiceInterface<${entity.name}Entity, ${entity.name}Repository> {

    @Autowired
    private ${entity.name}Repository ${entity.name?lower_case}Repository;

    @Override
    public ${entity.name}Repository getRepository() {
        return ${entity.name?lower_case}Repository;
    }

<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    public List<${entity.name}Entity> findAllWithout${relation.relationshipName?cap_first}() {
        return ${entity.name?lower_case}Repository.findAllWithout${relation.relationshipName?cap_first}();
    }

    public List<${entity.name}Entity> findAllWithout${relation.relationshipName?cap_first}(Long id) {
        return ${entity.name?lower_case}Repository.findAllWithoutOther${relation.relationshipName?cap_first}(id);
    }
  </#if>
  </#list>
</#if>
}
