import React from "react";
import {Route} from "react-router-dom";
import ${entity.name}Overview from "./${entity.name}Overview";
import ${entity.name}Detail from "./${entity.name}Detail";

function ${entity.name}Main() {
    return (
        <>
          <React.Fragment>
            <Route exact path="/${entity.name?lower_case}" component={${entity.name}Overview}/>
            <Route exact path="/${entity.name?lower_case}/create" component={${entity.name}Detail}/>
            <Route exact path="/${entity.name?lower_case}/update/:id" component={${entity.name}Detail}/>
          </React.Fragment>
        </>
    );
}

export default ${domain.name}Main;
