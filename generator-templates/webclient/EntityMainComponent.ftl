import React, { Component } from 'react';
import {Route} from 'react-router-dom';
import ${domain.name}All from "./all/${domain.name}All";
import ${domain.name}Single from "./single/${domain.name}Single";

class ${domain.name}Main extends Component {

  render() {

    return (
        <React.Fragment>
          <Route exact path="/${domain.name?lower_case}" component={${domain.name}All}/>
          <Route exact path="/${domain.name?lower_case}/create" component={${domain.name}Single}/>
          <Route exact path="/${domain.name?lower_case}/update/:id" component={${domain.name}Single}/>
        </React.Fragment>
    );
  }
}

export default ${domain.name}Main;
