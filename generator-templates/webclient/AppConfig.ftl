const appItems = [
<#if app.entities??>
<#list app.entities as entity>
    {title: "entity.name", link: "/${entity.name?lower_case}s/"},
];
</#list>
</#if>

export {appItems};
