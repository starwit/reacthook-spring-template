package de.${app.packagePrefix?lower_case}.service.impl;

import de.${app.packagePrefix?lower_case}.persistence.entity.${entity.name}Entity;
import de.${app.packagePrefix?lower_case}.persistence.repository.${entity.name}Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;

/**
 * 
 * ${entity.name} Service class
 *
 */
@Service
public class ${entity.name}Service implements ServiceInterface<App, AppRepository> {

    @Autowired
    private ${entity.name}Repository ${entity.name?lower_case}Repository;

    @Override
    public ${entity.name}Repository getRepository() {
        return ${entity.name?lower_case}Repository;
    }

}
