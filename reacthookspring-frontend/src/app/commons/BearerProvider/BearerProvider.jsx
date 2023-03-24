import {useEffect, useState} from "react";
import {useAuth} from "oidc-react";
import {CircularProgress} from "@material-ui/core";
import axios from "axios";

function BearerProvider(props) {
    const [headerSet, setHeaderSet] = useState(false);
    const auth = useAuth();
    const {children} = props;

    useEffect(() => {
        if (auth?.userData?.access_token) {
            if (!auth?.userData?.access_token) {
                return;
            }
            axios.defaults.headers.common["Authorization"] = `Bearer ${auth.userData.access_token}`;
            setHeaderSet(true);
        }
    }, [auth.userData?.access_token]);

    if (auth.isLoading || !headerSet){
        return <CircularProgress/>;
    }

    return children;

}

export default BearerProvider;