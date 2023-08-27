import {CssBaseline} from "@mui/material";
import {ErrorHandler} from "@starwit/react-starwit";
import React from "react";
import {useTranslation} from "react-i18next";
import {appItems} from "./AppConfig";
import MainContentRouter from "./MainContentRouter";
import logo from "./assets/images/logo-white.png";
import Navigation from "./commons/navigation/Navigation";

function App() {
    const {t} = useTranslation();

    return (
        <React.Fragment>
            <ErrorHandler>
                <Navigation menuItems={appItems} title={t("app.baseName")} logo={logo}>
                    <CssBaseline />
                    <MainContentRouter />
                </Navigation>
            </ErrorHandler>
        </React.Fragment>
    );
}

export default App;
