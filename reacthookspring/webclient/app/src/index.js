import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import App from "./app/App";
import * as serviceWorker from "./serviceWorker";
import {HashRouter as Router} from "react-router-dom";
import "./localization/i18n";
import {SnackbarProvider} from "notistack";
import MainTheme from "./app/assets/themes/MainTheme";
import BearerProvider from "./commons/BearerProvider/BearerProvider";
import {AuthProvider} from "oidc-react";

ReactDOM.render((
        <Router>
            <MainTheme>
                <AuthProvider
                    authority={window._env_.AUTH_AUTHORITY}
                    clientId={window._env_.AUTH_CLIENT_ID}
                    redirectUri={window.location.href}
                    autoSignIn={true}
                    automaticSilentRenew={true}
                    scope={"openid profile"}
                    onSignIn={() => {
                        console.log("on signin");
                    }}
                >
                    <BearerProvider>
                        <SnackbarProvider maxSnack={5}>
                            <App/>
                        </SnackbarProvider>
                    </BearerProvider>
                </AuthProvider>
            </MainTheme>
        </Router>
    ),
    document.getElementById("root")
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: http://bit.ly/CRA-PWA
serviceWorker.unregister();
