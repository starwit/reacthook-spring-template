import React from "react";
import AppHeader from "./appHeader/AppHeader";
import {useTranslation} from "react-i18next";
import DrawerNavigation from "./drawerNavigation/DrawerNavigation";

function Navigation(props) {
    const {t} = useTranslation();

    if (props.sideBar) {
        return (
            <>
                <DrawerNavigation menuItems={props.menuItems} title={t("app.baseName")}>
                    {props.children}
                </DrawerNavigation>
            </>
        )
    }

    return (
        <>
            <AppHeader menuItems={props.menuItems} title={t("app.baseName")}/>
            {props.children}
        </>
    )

}

export default Navigation;
