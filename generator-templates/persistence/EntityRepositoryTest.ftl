package de.starwit.persistence.repository;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import de.starwit.persistence.entity.${entity.name};

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
        List<App> apps = repository.findAll();
        assertTrue(apps.isEmpty());
    }
}
