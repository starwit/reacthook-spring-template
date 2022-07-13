package de.${app.packageName?lower_case}.service.impl;
<#assign additionalQueries = false >
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    <#assign additionalQueries = true>
  </#if>
  <#if relation.relationshipType == "OneToMany">
  <#if !oneToManyRelations??>
    <#assign oneToManyRelations = []>
  </#if>
    <#assign oneToManyRelations += [relation]>
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

<#if oneToManyRelations??>
import java.util.Set;
<#list (oneToManyRelations) as oneToMany>
import de.${app.packageName?lower_case}.persistence.entity.${oneToMany.otherEntityName}Entity;
import de.${app.packageName?lower_case}.persistence.repository.${oneToMany.otherEntityName}Repository;
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
    <#if oneToManyRelations??>
    <#list (oneToManyRelations) as oneToMany>

    @Autowired
    private ${oneToMany.otherEntityName}Repository ${oneToMany.otherEntityName?lower_case}Repository;
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

<#if oneToManyRelations??>
    @Override
    public ${entity.name}Entity saveOrUpdate(${entity.name}Entity entity) {

    <#list (oneToManyRelations) as oneToMany>
        Set<${oneToMany.otherEntityName}Entity> ${oneToMany.relationshipName}ToSave = entity.get${oneToMany.relationshipName?cap_first}();
    </#list>

        if (entity.getId() != null) {
            ${entity.name}Entity entityPrev = this.findById(entity.getId());
            <#list (oneToManyRelations) as oneToMany>
            for (${oneToMany.otherEntityName}Entity item : entityPrev.get${oneToMany.relationshipName?cap_first}()) {
                ${oneToMany.otherEntityName}Entity existingItem = ${oneToMany.otherEntityName?lower_case}Repository.getById(item.getId());
                existingItem.set${oneToMany.otherEntityRelationshipName?cap_first}(null);
                this.${oneToMany.otherEntityName?lower_case}Repository.save(existingItem);
            }
            </#list>
        }

        <#list (oneToManyRelations) as oneToMany>
        entity.set${oneToMany.relationshipName?cap_first}(null);
        </#list>
        entity = this.getRepository().save(entity);
        this.getRepository().flush();

        <#list (oneToManyRelations) as oneToMany>
        if (${oneToMany.relationshipName}ToSave != null && !${oneToMany.relationshipName}ToSave.isEmpty()) {
            for (${oneToMany.otherEntityName}Entity item : ${oneToMany.relationshipName}ToSave) {
                ${oneToMany.otherEntityName}Entity newItem = ${oneToMany.otherEntityName?lower_case}Repository.getById(item.getId());
                newItem.set${oneToMany.otherEntityRelationshipName?cap_first}(entity);
                ${oneToMany.otherEntityName?lower_case}Repository.save(newItem);
            }
        }
        </#list>
        return this.getRepository().getById(entity.getId());
    }
</#if>
}
