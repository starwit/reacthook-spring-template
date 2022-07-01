package de.${app.packageName?lower_case}.rest.controller;

import java.util.List;

import javax.persistence.EntityNotFoundException;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import de.${app.packageName?lower_case}.persistence.entity.${entity.name}Entity;
import de.${app.packageName?lower_case}.service.impl.${entity.name}Service;
import de.${app.packageName?lower_case}.persistence.exception.NotificationException;
import de.${app.packageName?lower_case}.rest.exception.NotificationDto;
import io.swagger.v3.oas.annotations.Operation;

/**
 * ${entity.name} RestController
 * Have a look at the RequestMapping!!!!!!
 */
@RestController
@RequestMapping("${r"${rest.base-path}"}/${entity.name?lower_case}")
public class ${entity.name}Controller {

    static final Logger LOG = LoggerFactory.getLogger(${entity.name}Controller.class);

    @Autowired
    private ${entity.name}Service ${entity.name?lower_case}Service;

    @Operation(summary = "Get all ${entity.name?lower_case}")
    @GetMapping
    public List<${entity.name}Entity> findAll() {
        return this.${entity.name?lower_case}Service.findAll();
    }

<#if entity.relationships??>
  <#list (entity.relationships) as relation>
  <#if relation.relationshipType == "OneToOne" || relation.relationshipType == "ManyToOne">
    @Operation(summary = "Get all ${entity.name?lower_case} without ${relation.relationshipName}")
    @GetMapping(value = "find-without-${relation.relationshipName}")
    public List<${entity.name}Entity> findAllWithout${relation.relationshipName?cap_first}() {
        return ${entity.name?lower_case}Service.findAllWithout${relation.relationshipName?cap_first}();
    }

    @Operation(summary = "Get all ${entity.name?lower_case} without other ${relation.relationshipName}")
    @GetMapping(value = "find-without-other-${relation.relationshipName}/{id}")
    public List<${entity.name}Entity> findAllWithoutOther${relation.relationshipName?cap_first}(@PathVariable("id") Long id) {
        return ${entity.name?lower_case}Service.findAllWithoutOther${relation.relationshipName?cap_first}(id);
    }
  </#if>
  </#list>
</#if>

    @Operation(summary = "Get ${entity.name?lower_case} with id")
    @GetMapping(value = "/{id}")
    public ${entity.name}Entity findById(@PathVariable("id") Long id) {
        return this.${entity.name?lower_case}Service.findById(id);
    }

    @Operation(summary = "Create ${entity.name?lower_case}")
    @PostMapping
    public ${entity.name}Entity save(@Valid @RequestBody ${entity.name}Entity entity) {
        return update(entity);
    }

    @Operation(summary = "Update ${entity.name?lower_case}")
    @PutMapping
    public ${entity.name}Entity update(@Valid @RequestBody ${entity.name}Entity entity) {
        return ${entity.name?lower_case}Service.saveOrUpdate(entity);
    }

    @Operation(summary = "Delete ${entity.name?lower_case}")
    @DeleteMapping(value = "/{id}")
    public void delete(@PathVariable("id") Long id) throws NotificationException {
        ${entity.name?lower_case}Service.delete(id);
    }

    @ExceptionHandler(value = { EntityNotFoundException.class })
    public ResponseEntity<Object> handleException(EntityNotFoundException ex) {
        LOG.info("${entity.name} not found. {}", ex.getMessage());
        NotificationDto output = new NotificationDto("error.${entity.name?lower_case}.notfound", "${entity.name} not found.");
        return new ResponseEntity<>(output, HttpStatus.NOT_FOUND);
    }
}
