import React from "react";
import {Route} from "react-router-dom";
import ${entity.name}Overview from "./features/${entity.name?uncap_first}/${entity.name}Overview";
import ${entity.name}Detail from "./features/${domain.name?uncap_first}/${entity.name}Detail";
import Home from "./features/home/Home";

function MainContentRouter() {
    return (
        <>
<#if app.entities??>
<#list app.entities as entity>
            <Route exact path={"/${entity.name?lower_case}s/:id"} component={${entity.name}Detail}/>
            <Route exact path={"/${entity.name?lower_case}s/"} component={${entity.name}Overview}/>
            <Route exact path={"/"} component={Home}/>
            <Route path="/logout" component={() => {
                window.location.href = window.location.pathname + "api/user/logout";
                return null;
            }}/>
        </>
    );
}
</#list>
</#if>
export default MainContentRouter;