package de.${app.packagePrefix?lower_case}.persistence.repository;

import de.${app.packagePrefix?lower_case}.persistence.entity.${field.name}Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * ${field.name} Repository class
 */
@Repository
public interface ${field.name}Repository extends JpaRepository<${field.name}Entity, Long> {

}
