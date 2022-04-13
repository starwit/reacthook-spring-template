package de.${app.packagePrefix?lower_case}.persistence.repository;

import de.${app.packagePrefix?lower_case}.persistence.entity.${domain.name}Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * ${domain.name} Repository class
 */
@Repository
public interface ${domain.name}Repository extends JpaRepository<${domain.name}Entity, Long> {

}
