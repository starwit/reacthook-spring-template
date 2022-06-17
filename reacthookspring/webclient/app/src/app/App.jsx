import React from "react";
import MainContentRouter from "./MainContentRouter";
import {CssBaseline} from "@mui/material";
import {ErrorHandler} from "@starwit/react-starwit";
import {AppHeader} from "./commons/appHeader";
import {useTranslation} from "react-i18next";
import {appItems} from "./AppConfig";

function App() {
    const {t} = useTranslation();

    return (
        <React.Fragment>
            <ErrorHandler>
                <div>
                    <CssBaseline/>
                    <AppHeader menuItems={appItems} title={t("app.baseName")} />
                    <MainContentRouter/>
                </div>
            </ErrorHandler>
        </React.Fragment>
    );
}

export default App;
