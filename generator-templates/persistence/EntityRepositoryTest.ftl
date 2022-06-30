package de.${app.packageName?lower_case}.persistence.repository;

import static org.junit.jupiter.api.Assertions.assertTrue;

import de.${app.packageName?lower_case}.persistence.entity.${entity.name}Entity;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

/**
 * Tests for ${entity.name}Repository
 */
@DataJpaTest
public class ${entity.name}RepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private ${entity.name}Repository repository;

    @Test
    public void testFindAll() {
        List<${entity.name}Entity> ${entity.name?lower_case}s = repository.findAll();
        assertTrue(${entity.name?lower_case}s.isEmpty());
    }
}
