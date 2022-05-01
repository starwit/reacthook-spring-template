const appItems = [
<#if app.entities??>
<#list app.entities as entity>
    {title: "${entity.name?uncap_first}.title", link: "/${entity.name?lower_case}/"}<#sep>,</#sep>
</#list>
</#if>
];

export {appItems};
