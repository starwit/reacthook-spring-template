import CrudRest from "./CrudRest";

class ${entity.name}Rest extends CrudRest {

    constructor() {
        super(window.location.pathname + "api/${entity.name?lower_case}");
    }

}

export default ${entity.name}Rest;
