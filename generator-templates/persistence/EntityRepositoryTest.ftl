package de.${app.packageName?lower_case}.persistence.repository;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import de.${app.packageName?lower_case}.persistence.entity.${entity.name}Entity;

import java.util.ArrayList;
import java.util.List;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.context.junit4.SpringRunner;


import static org.junit.Assert.*;

/**
 * Tests for ${entity.name}Repository
 */
@RunWith(SpringRunner.class)
@DataJpaTest
public class ${entity.name}RepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private ${entity.name}Repository ${entity.name?lower_case}Repository;

    @Test
    public void testFindAll() {
        List<${entity.name}> ${entity.name?lower_case}s = repository.findAll();
        assertTrue(apps.isEmpty());
    }
}
