import React, {useMemo, useEffect} from "react";
import {useParams} from "react-router";
import {useImmer} from "use-immer";
import ${entity.name}Rest  from "../../services/${entity.name}Rest ";
<#if entity.relationships??>
//entity relations
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne" || relation.relationshipType == "ManyToMany">
import ${relation.otherEntityName}Rest from "../../services/${relation.otherEntityName}Rest";
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
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne" || relation.relationshipType == "ManyToMany">
    const ${relation.otherEntityName?lower_case}Rest = useMemo(() => new ${relation.otherEntityName}Rest(), []);
  </#if>
  </#list>
</#if>
    const userRest = useMemo(() => new UserRest(), []);
    const {id} = useParams();

    useEffect(() => {
        reloadSelectLists();
    }, [id]);

    function reloadSelectLists() {
        const selectLists = [];
        const functions = [
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne" || relation.relationshipType == "ManyToMany">
            ${relation.otherEntityName?lower_case}Rest.findAll(),
  </#if>
  </#list>
</#if>
        ];
        Promise.all(functions).then(values => {
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne" || relation.relationshipType == "ManyToMany">
            selectLists.push({name: "${relation.relationshipName}", data: values[${relation?index}].data});
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
