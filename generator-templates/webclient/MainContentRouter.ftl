import React from "react";
import {Route, Switch} from "react-router-dom";
<#if app.entities??>
<#list app.entities as entity>
import ${entity.name}Main from "./features/${entity.name?uncap_first}/${entity.name}Main";
</#list>
</#if>
import Home from "./features/home/Home";

function MainContentRouter() {
    return (
        <>
<#if app.entities??>
            <Switch>
<#list app.entities as entity>
                <Route path={"/${entity.name?lower_case}"} component={${entity.name}Main}/>
</#list>
            </Switch>
</#if>
            <Route exact path={"/"} component={Home}/>
            <Route path="/logout" component={() => {
                window.location.href = window.location.pathname + "api/user/logout";
                return null;
            }}/>
        </>
    );
}

export default MainContentRouter;
