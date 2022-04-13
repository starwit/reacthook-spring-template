import React, { Component } from "react";
import { Route, Switch } from "react-router-dom";
import { withRouter } from "react-router-dom";
// Material UI Components
import { withStyles } from "@material-ui/core/styles";
// Page Components
import Home from "./home/HomeMain";
<#list app.domains as domain>
import ${domain.name}Main from "./${domain.name?lower_case}/${domain.name}Main";
</#list>

import MenuStyles from "../assets/styles/MenuStyles";

class MainContentRouter extends Component {

    render() {
        const { classes} = this.props;

        return (
            <main className={classes.content}>
                <div className={classes.toolbar} />
                <Switch>
                    <#list app.domains as domain>
                    <Route
                        path="/${domain.name?lower_case}"
                        component={${domain.name}Main}/>
                    </#list>
                    <Route
                        path="/"
                        component={Home}/>
                </Switch>
            </main>
        );
    }
}

export default withStyles(MenuStyles, { withTheme: true })(withRouter(MainContentRouter));
