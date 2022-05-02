<#assign addRestCalls = false>
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    <#assign addRestCalls = true>
  </#if>
  </#list>
</#if>
import CrudRest from "./CrudRest";
<#if addRestCalls>
import axios from "axios";
</#if>

class ${entity.name}Rest extends CrudRest {
    constructor() {
        super(window.location.pathname + "api/${entity.name?lower_case}");
    }
<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">

    findAllWithout${relation.relationshipName?cap_first}() {
        return axios.put(this.baseUrl + "/find-without-${relation.relationshipName}/");
    }
  </#if>
  </#list>
</#if>
}
export default ${entity.name}Rest;
