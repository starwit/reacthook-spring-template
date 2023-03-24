import axios from "axios";

class VersionRest {
    constructor() {
        this.baseUrl = window._env_.API_URL + + "/monitoring";
    }

    info = () => {
        return axios.get(this.baseUrl + "/info");
    };
}

export default VersionRest;
