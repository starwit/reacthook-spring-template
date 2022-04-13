import CrudRest from "./CrudRest";

class ${domain.name}Rest extends CrudRest {

    constructor() {
        super(window.location.pathname + "api/${domain.name?lower_case}");
    }

}

export default ${domain.name}Rest;
