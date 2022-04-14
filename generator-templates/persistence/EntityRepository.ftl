package de.${app.packagePrefix?lower_case}.persistence.repository;

import de.${app.packagePrefix?lower_case}.persistence.entity.${field.name}Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * ${entity.name} Repository class
 */
@Repository
public interface ${entity.name}Repository extends JpaRepository<${entity.name}Entity, Long> {

}
