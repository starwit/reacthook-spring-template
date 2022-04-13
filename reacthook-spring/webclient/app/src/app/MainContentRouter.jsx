import React from "react";
import {Route} from "react-router-dom";
import Home from "./features/home/Home";

function MainContentRouter() {
    return (
        <>
            <Route exact path={"/"} component={Home}/>
            <Route path="/logout" component={() => {
                window.location.href = window.location.pathname + "api/user/logout";
                return null;
            }}/>
        </>
    );
}

export default MainContentRouter;
