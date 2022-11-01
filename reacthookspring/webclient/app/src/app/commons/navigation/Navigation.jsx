import React from "react";
import AppHeader from "./appHeader/AppHeader";
import SidebarNavigation from "./sidebarNavigation/SidebarNavigation";
import NavigationStyles from "./NavigationStyles";

function Navigation(props) {
    const {menuItems, switchLength, title, logo} = props;
    const navigationStyles = NavigationStyles();


    function renderCorrectNavigation() {
        if (menuItems.length > switchLength) {
            return (
                <>
                    <SidebarNavigation menuItems={menuItems} title={title} logo={logo}>
                        {props.children}
                    </SidebarNavigation>
                </>
            )
        }

        return (
            <>
                <AppHeader menuItems={menuItems} title={title} logo={logo}/>
                {props.children}
            </>
        )
    }

    return(
        <div className={navigationStyles.contentSpacer}>
            {renderCorrectNavigation()}
        </div>
    )

}

Navigation.defaultProps = {
    switchLength: 4,
    title: "New App",
    menuItems: []

}

export default Navigation;
