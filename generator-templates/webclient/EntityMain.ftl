import React from "react";
import {Route} from "react-router-dom";
import ${entity.name}Overview from "./${entity.name}Overview";
import ${entity.name}Detail from "./${entity.name}Detail";

function ${entity.name}Main() {
    return (
        <>
            <React.Fragment>
                <Route exact path="/${entity.name?lower_case}s" component={${entity.name}Overview}/>
                <Route exact path="/${entity.name?lower_case}s/create" component={${entity.name}Detail}/>
                <Route exact path="/${entity.name?lower_case}s/update/:id" component={${entity.name}Detail}/>
            </React.Fragment>
        </>
    );
}

export default ${domain.name}Main;
