import React, {Component} from 'react';
import {withTranslation} from "react-i18next";
import Typography from "@material-ui/core/Typography";
import Button from "@material-ui/core/Button";

import ${domain.name}Rest from "../../../services/${domain.name}Rest";
import AllTable from "../../../commons/table/AllTable";


class ${domain.name}All extends Component {
    
    state = {
        isLoading: true,
        ${domain.name?uncap_first}All: [],
        selected: undefined,
        columns: []
    };
    
    ${domain.name?uncap_first}Rest = new ${domain.name}Rest();

    fetchAll = () => {
        this.${domain.name?uncap_first}Rest.findAll().then(response => {
            this.setState({${domain.name?uncap_first}All: response.data, isLoading: false});
        });
    };

    componentDidMount = () => {

        const {t} = this.props;

        const columns = [
            <#list domain.getAttributes() as attribute>
            {title: t('${domain.name?uncap_first}.${attribute.name}'), field: '${attribute.name}'}<#sep>,
            </#list>
        ];

        this.setState({columns: columns});
        this.fetchAll();
    };

    render() {

        const {t} = this.props;
        const {columns, ${domain.name?uncap_first}All, selected} = this.state;

        if (this.state.isLoading) {
            return <div>Loading...</div>;
        }

        return (
            <React.Fragment>
                <Typography variant="h1" color="primary">{t('${domain.name?uncap_first}.title')}</Typography>
                <Button onClick={this.goToCreate} variant="contained" color="primary">{t('button.create')}</Button>
                <Button onClick={this.goToUpdate} variant="contained" color="primary">{t('button.update')}</Button>
                <Button onClick={this.delete} variant="contained" color="primary">{t('button.delete')}</Button>
                <AllTable
                    entities={${domain.name?uncap_first}All}
                    selected={selected}
                    onRowClick={this.rowClick}
                    columns={columns}/>
            </React.Fragment>
        );
    };

    goToCreate = () => {
        this.props.history.push("/${domain.name?lower_case}/create");
    };

    goToUpdate = () => {
        if (this.state.selected) {
            this.props.history.push("/${domain.name?lower_case}/update/" + this.state.selected.id);
            this.setState({selected: undefined});
        }
    };

    delete = () => {
        if (this.state.selected) {
            this.${domain.name?uncap_first}Rest.delete(this.state.selected).then(this.fetchAll);
            this.setState({selected: undefined});
        }
    };

    rowClick = (${domain.name?uncap_first}) => {
        this.setState({selected: ${domain.name?uncap_first}});
    };

}

export default withTranslation()(${domain.name}All);
