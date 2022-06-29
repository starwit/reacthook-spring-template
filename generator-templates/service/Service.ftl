package de.${app.packageName?lower_case}.service.impl;
<#assign additionalQueries = false >
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    <#assign additionalQueries = true>
  </#if>
  <#if relation.relationshipType == "ManyToOne">
    <#assign manyToOneRelations += [relation.relationshipName]>
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

<#if manyToOneRelations??>
import java.util.Set;
<#list (manyToOneRelations) as manyToOne>
import de.${app.packageName?lower_case}.persistence.entity.${manyToOne.otherEntityName}Entity;
import de.${app.packageName?lower_case}.persistence.repository.${manyToOne.otherEntityName}Repository;
</#list>
</#if>

/**
 * 
 * ${entity.name} Service class
 *
 */
@Service
public class ${entity.name}Service implements ServiceInterface<${entity.name}Entity, ${entity.name}Repository> {

    @Autowired
    private ${entity.name}Repository ${entity.name?lower_case}Repository;
    <#if manyToOneRelations??>
    <#list (manyToOneRelations) as manyToOne>

    @Autowired
    private ${manyToOne.otherEntityName}Repository ${manyToOne.otherEntityName?lower_case}Repository;
    </#list>
    </#if>

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

    public List<${entity.name}Entity> findAllWithoutOther${relation.relationshipName?cap_first}(Long id) {
        return ${entity.name?lower_case}Repository.findAllWithoutOther${relation.relationshipName?cap_first}(id);
    }
  </#if>
  </#list>
</#if>

<#if manyToOneRelations??>
    @Override
    public ${entity.name}Entity saveOrUpdate(${entity.name}Entity entity) {

    <#list (manyToOneRelations) as manyToOne>
        Set<${manyToOne.otherEntityName}Entity> ${manyToOne.relationshipName}ToSave = entity.get${manyToOne.relationshipName?cap_first}();
    </#list>

        if (entity.getId() != null) {
            ${entity.name}Entity entityPrev = this.findById(entity.getId());
            <#list (manyToOneRelations) as manyToOne>
            for (${manyToOne.otherEntityName}Entity item : entityPrev.get${manyToOne.relationshipName?cap_first}()) {
                ${manyToOne.otherEntityName}Entity existingItem = ${manyToOne.otherEntityName?lower_case}Repository.getById(item.getId());
                existingItem.set${manyToOne.otherEntityRelationshipName?cap_first}(null);
                this.${manyToOne.otherEntityName?lower_case}Repository.save(existingItem);
            }
            </#list>
        }

        <#list (manyToOneRelations) as manyToOne>
        entity.set${manyToOne.relationshipName?cap_first}();
        </#list>
        entity = this.getRepository().save(entity);
        this.getRepository().flush();

        <#list (manyToOneRelations) as manyToOne>
        if (${manyToOne.relationshipName}ToSave != null && !${manyToOne.relationshipName}ToSave.isEmpty()) {
          for (${manyToOne.otherEntityName}Entity item : ${manyToOne.relationshipName}ToSave) {
              ${manyToOne.otherEntityName}Entity newItem = ${manyToOne.otherEntityName?lower_case}Repository.getById(item.getId());
              newItem.set${manyToOne.otherEntityRelationshipName?cap_first}(entity);
              ${manyToOne.otherEntityName?lower_case}Repository.save(newItem);
          }
        }
        </#list>
        return this.getRepository().getById(entity.getId());
    }
</#if>
}
