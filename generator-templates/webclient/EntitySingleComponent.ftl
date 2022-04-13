import React, {Component} from 'react';
import {withRouter} from "react-router-dom";

import ${domain.name}Rest from "../../../services/${domain.name}Rest";
import AddUpdateForm from "../../../commons/form/AddUpdateForm";
import Typography from "@material-ui/core/Typography";

import {withTranslation} from "react-i18next";

class ${domain.name}Single extends Component {

    state = {
        ${domain.name?uncap_first}: {
        <#list domain.getAttributes() as attribute>
            ${attribute.name}: ""<#sep>,
        </#list>}
        ,
        titleKey: ""
    };

    ${domain.name?uncap_first}Rest = new ${domain.name}Rest();

    attributes = [
    <#list domain.getAttributes() as attribute>
        <#if attribute.dataType == "String" ||  attribute.dataType == "Enum">
    {name: "${attribute.name}", type: "string"}<#sep>,
        </#if>
        <#if attribute.dataType == "Integer">
    {name: "${attribute.name}", type: "number", inputProps: {step: "1"}}<#sep>,
        </#if>
        <#if attribute.dataType == "BigDecimal" || attribute.dataType == "Double">
    {name: "${attribute.name}", type: "number", inputProps: {step: "0.01"}}<#sep>,
        </#if>
        <#if attribute.dataType == "Date">
    {name: "${attribute.name}", type: "date"}<#sep>,
        </#if>
        <#if attribute.dataType == "Time">
    {name: "${attribute.name}", type: "time", inputProps: {min: "00:00", max: "24:00", step: "1"}}<#sep>,
        </#if>
        <#if attribute.dataType == "Timestamp">
    {name: "${attribute.name}", type: "datetime-local"}<#sep>,
        </#if>
    </#list>
    ];

    componentDidMount = () => {
        let updateResult = this.checkUpdate();
        this.submitFunction = updateResult.submitFunction;
        this.setState({titleKey: updateResult.titleKey});
    };

    render() {

        const {t} = this.props;

        if (!this.state.${domain.name?uncap_first}) {
            return (<div>Loading...</div>);
        }

        return (
            <React.Fragment>
                <Typography variant="h1" color="primary">{t(this.state.titleKey, {entity: t('${domain.name?uncap_first}')})}</Typography>
                <AddUpdateForm
                    entity={this.state.${domain.name?uncap_first}}
                    attributes={this.attributes}
                    prefix='${domain.name?uncap_first}'
                    handleSubmit={this.handleSubmit}
                    handleChange={this.handleChange}
                />
            </React.Fragment>
        );
    }

    checkUpdate() {
        let func;
        let titleKey = "";
        if (this.props.match.params.id === undefined) {
            func = this.${domain.name?uncap_first}Rest.create;
            titleKey = "form.create";
        } else {
            this.${domain.name?uncap_first}Rest.findById(this.props.match.params.id).then(response => this.set${domain.name}(response.data));
            func = this.${domain.name?uncap_first}Rest.update;
            titleKey = "form.update";
        }
        return {submitFunction: func, titleKey: titleKey};
    };

    set${domain.name} = (data) => {
        this.setState({
            ${domain.name?uncap_first}: data
        });
    };

    handleChange = (event) => {
        const target = event.target;
        const value = target.type === 'checkbox' ? target.checked : target.value;
        const name = target.name;

        let ${domain.name?uncap_first} = this.state.${domain.name?uncap_first};
        ${domain.name?uncap_first}[name] = value;

        this.setState({
            ${domain.name?uncap_first}: ${domain.name?uncap_first}
        });
    };

    handleSubmit = (event) => {

        //turn off page relaod
        event.preventDefault();

        let ${domain.name?uncap_first} = this.state.${domain.name?uncap_first};

        this.attributes.forEach(attribute => {
           if (attribute.type === "time") {
               let date = new Date("1970-01-01T" + this.state.${domain.name?uncap_first}[attribute.name]);
               ${domain.name?uncap_first}[attribute.name] = date.toISOString();
           }
        });

        this.submitFunction(${domain.name?uncap_first}).then(this.goBack);
    };

    goBack = () => {
        this.props.history.push("/${domain.name?lower_case}");
    };

}

export default withTranslation()(withRouter(${domain.name}Single));
