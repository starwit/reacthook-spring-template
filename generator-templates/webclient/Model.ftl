// class representing the ${domain.name} entity
class ${domain.name} {

    constructor(data) {
        this.id = data.id;
        <#list (domain.getAttributes()) as attribute> 
        this.${attribute.name} = data.${attribute.name};
        </#list>
    }
}

export default ${domain.name};