import React from "react";
import AppHeader from "./commons/appHeader/AppHeader";
import MainContentRouter from "./MainContentRouter";
import {CssBaseline} from "@mui/material";
import ErrorHandler from "./commons/errorHandler/ErrorHandler";
import {appMenuItems} from "./AppConfig";

function App() {
    return (
        <React.Fragment>
            <ErrorHandler>
                <div>
                    <CssBaseline/>
                    <AppHeader menuItems={appMenuItems}/>
                    <MainContentRouter/>
                </div>
            </ErrorHandler>
        </React.Fragment>
    );
}

export default App;
