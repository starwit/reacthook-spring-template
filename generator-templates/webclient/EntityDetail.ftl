import React, {useMemo, useEffect} from "react";
import {useParams} from "react-router";
import {useImmer} from "use-immer";
import ${entity.name}Rest from "../../services/${entity.name}Rest";
<#if entity.relationships??>
  <#assign seen_rest = []>
  <#list (entity.relationships) as relation>
  <#if relation.ownerSide>
  <#if seen_rest?seq_contains(relation.otherEntityName)>
  <#else>
  <#assign seen_rest = seen_rest + [relation.otherEntityName]>
import ${relation.otherEntityName}Rest from "../../services/${relation.otherEntityName}Rest";
  </#if>
  </#if>
  </#list>
</#if>
import {
    entityDefault,
    entityFields
} from "../../modifiers/${entity.name}Modifier";
import EntityDetail from "../../commons/form/EntityDetail";
import {addSelectLists} from "../../modifiers/DefaultModifier";

function ${entity.name}Detail() {
    const [entity, setEntity] = useImmer(entityDefault);
    const [fields, setFields] = useImmer(entityFields);
    const entityRest = useMemo(() => new ${entity.name}Rest(), []);
<#if entity.relationships??>
  <#assign seen_rest2 = []>
  <#list (entity.relationships) as relation>
  <#if relation.ownerSide>
  <#if seen_rest2?seq_contains(relation.otherEntityName)>
  <#else>
  <#assign seen_rest2 = seen_rest2 + [relation.otherEntityName]>
    const ${relation.otherEntityName?lower_case}Rest = useMemo(() => new ${relation.otherEntityName}Rest(), []);
  </#if>
  </#if>
  </#list>
</#if>
    const {id} = useParams();

    useEffect(() => {
        reloadSelectLists();
    }, [id]);

    function reloadSelectLists() {
        const selectLists = [];
        const functions = [
<#if entity.relationships??>
  <#assign seen_rest3 = []>
  <#list (entity.relationships) as relation>
  <#if relation.ownerSide>
  <#if seen_rest3?seq_contains(relation.otherEntityName)>
  <#else>
    <#assign seen_rest3 = seen_rest3 + [relation.otherEntityName]>
    <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
            ${relation.otherEntityName?lower_case}Rest.findAllWithout${relation.otherEntityRelationshipName?cap_first}()<#sep>,</#sep>
    <#else>
            ${relation.otherEntityName?lower_case}Rest.findAll()<#sep>,</#sep>
    </#if>
  </#if>
  </#if>
  </#list>
</#if>
        ];
        Promise.all(functions).then(values => {
<#if entity.relationships??>
  <#assign seen_rest3 = []>
  <#list (entity.relationships) as relation>
  <#if relation.ownerSide>
  <#if seen_rest3?seq_contains(relation.otherEntityName)>
  <#else>
  <#assign seen_rest3 = seen_rest3 + [relation.otherEntityName]>
            selectLists.push({name: "${relation.relationshipName}", data: values[${relation?index}].data});
  </#if>
  </#if>
  </#list>
</#if>
            if (id) {
                entityRest.findById(id).then(response => {
                    setEntity(response.data);
                    addSelectLists(response.data, fields, setFields, selectLists);
                });
            } else {
                addSelectLists(entity, fields, setFields, selectLists);
            }
        });
    }

    return (
        <>
            <EntityDetail
                id={id}
                entity={entity}
                setEntity={setEntity}
                fields={fields}
                setFields={setFields}
                entityRest={entityRest}
                prefix="${entity.name?uncap_first}"
            />
        </>

    );
}

export default ${entity.name}Detail;
