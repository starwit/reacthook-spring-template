import React from "react";
import AppHeader from "./appHeader/AppHeader";
import {useTranslation} from "react-i18next";
import SidebarNavigation from "./sidebarNavigation/SidebarNavigation";

function Navigation(props) {
    const {t} = useTranslation();

    if (props.sideBar) {
        return (
            <>
                <SidebarNavigation menuItems={props.menuItems} title={t("app.baseName")}>
                    {props.children}
                </SidebarNavigation>
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
